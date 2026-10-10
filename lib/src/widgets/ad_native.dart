import 'dart:async';

import 'package:eyehelper/src/helpers/ads/ads_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Native ad in Google's small template — one row of icon, text and a
/// call-to-action button, styled like the app's cards. Same ownership rules
/// as [AdBanner]: [AdsService] loads and keeps the ad, this only shows it.
class AdNative extends StatefulWidget {
  const AdNative({
    super.key,
    required this.placement,
    this.margin = EdgeInsets.zero,
    this.height = 64,
  });

  final String placement;
  final EdgeInsets margin;

  /// The row factory lays out at 64 pt; the box has to match.
  final double height;

  @override
  State<AdNative> createState() => _AdNativeState();
}

class _AdNativeState extends State<AdNative> {
  NativeAd? _ad;
  bool _requested = false;
  Timer? _retry;

  @override
  void initState() {
    super.initState();
    AdsService().ready.addListener(_onAdsReady);
    _resolve();
  }

  @override
  void dispose() {
    AdsService().ready.removeListener(_onAdsReady);
    _retry?.cancel();
    super.dispose();
  }

  void _onAdsReady() {
    if (mounted && _ad == null) {
      _requested = false;
      _resolve();
    }
  }

  Future<void> _resolve() async {
    if (_requested) {
      return;
    }
    _requested = true;
    final ads = AdsService();
    final ad = await ads.native(widget.placement);
    if (!mounted) {
      return;
    }
    if (ad == null) {
      _requested = false;
      if (ads.canShowAds) {
        _retry ??= Timer(const Duration(seconds: 31), () {
          _retry = null;
          if (mounted) {
            _resolve();
          }
        });
      }
      return;
    }
    setState(() => _ad = ad);
  }

  @override
  Widget build(BuildContext context) {
    final ad = _ad;
    if (ad == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: widget.margin,
      height: widget.height,
      // The template paints its own white rounded card; the shadow is ours
      // so it matches the neighbours.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AdWidget(ad: ad),
      ),
    );
  }
}
