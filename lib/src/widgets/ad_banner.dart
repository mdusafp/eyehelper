import 'dart:async';

import 'package:eyehelper/src/helpers/ads/ads_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Draws a red block where the banner will sit instead of requesting a real
/// ad, so the placement can be judged without AdMob, consent or a network.
///
/// Set to `false` to get actual ads back.
const bool kAdPlaceholderMode = false;

/// Height used when the SDK cannot report an adaptive size — the smallest
/// banner AdMob will ever serve.
const double _kFallbackBannerHeight = 50.0;

/// Anchored adaptive banner.
///
/// The ad itself belongs to [AdsService], loaded once per [placement] and
/// kept for the session — this widget only shows it, so leaving and
/// re-entering the screen costs no new request. Takes up no space until an
/// ad is there, and reports its height so the host can reserve room for it.
/// [margin], [padding] and [decoration] frame the ad; the creative itself is
/// never clipped beyond [borderRadius], which AdMob tolerates when small.
class AdBanner extends StatefulWidget {
  const AdBanner({
    super.key,
    required this.placement,
    this.onHeightChanged,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.borderRadius,
  });

  /// Names the slot — one banner per screen, cached under this key.
  final String placement;

  /// Total height taken by the banner including [margin] and [padding].
  final ValueChanged<double>? onHeightChanged;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BoxDecoration? decoration;
  final BorderRadius? borderRadius;

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _ad;
  double? _placeholderHeight;
  int? _requestedWidth;
  Timer? _retry;

  double get _frameHeight => widget.margin.vertical + widget.padding.vertical;

  @override
  void initState() {
    super.initState();
    AdsService().ready.addListener(_onAdsReady);
  }

  @override
  void dispose() {
    debugPrint('Banner "${widget.placement}": disposed');
    AdsService().ready.removeListener(_onAdsReady);
    _retry?.cancel();
    super.dispose();
  }

  /// The screen may well be built before consent and the SDK are through;
  /// when they are, try again.
  void _onAdsReady() {
    if (mounted && _ad == null) {
      setState(() => _requestedWidth = null);
    }
  }

  Future<void> _resolve(double availableWidth) async {
    final width = (availableWidth - widget.margin.horizontal - widget.padding.horizontal).truncate();
    if (_requestedWidth == width) {
      return;
    }
    _requestedWidth = width;

    if (kAdPlaceholderMode) {
      double height = _kFallbackBannerHeight;
      try {
        height = (await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width))?.height.toDouble() ?? height;
      } catch (e) {
        debugPrint('Could not resolve adaptive banner size: $e');
      }
      if (!mounted) {
        return;
      }
      setState(() => _placeholderHeight = height);
      widget.onHeightChanged?.call(height + _frameHeight);
      return;
    }

    final ads = AdsService();
    final ad = await ads.banner(widget.placement, width: width);
    if (!mounted) {
      debugPrint('Banner "${widget.placement}": widget gone before the ad arrived');
      return;
    }
    if (ad == null) {
      debugPrint('Banner "${widget.placement}": service returned null');
      // Not ready yet (the ready listener will retry) or the load failed —
      // ask again once the service's retry delay has passed.
      _requestedWidth = null;
      if (ads.canShowAds) {
        _retry ??= Timer(const Duration(seconds: 31), () {
          _retry = null;
          if (mounted) {
            setState(() {});
          }
        });
      }
      return;
    }
    debugPrint('Banner "${widget.placement}": mounting ${ad.size.width}x${ad.size.height}');
    setState(() => _ad = ad);
    widget.onHeightChanged?.call(ad.size.height.toDouble() + _frameHeight);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.sizeOf(context).width;
        _resolve(width);

        final Widget ad;
        if (kAdPlaceholderMode) {
          final height = _placeholderHeight;
          if (height == null) {
            return const SizedBox.shrink();
          }
          final adWidth = width - widget.margin.horizontal - widget.padding.horizontal;
          ad = Container(
            width: double.infinity,
            height: height,
            color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              'AD ${adWidth.truncate()}x${height.truncate()}',
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          );
        } else {
          final loaded = _ad;
          if (loaded == null) {
            return const SizedBox.shrink();
          }
          debugPrint('Banner "${widget.placement}": building AdWidget');
          ad = SizedBox(
            width: loaded.size.width.toDouble(),
            height: loaded.size.height.toDouble(),
            child: AdWidget(ad: loaded),
          );
        }

        final radius = widget.borderRadius;
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          decoration: widget.decoration,
          alignment: Alignment.center,
          child: radius == null ? ad : ClipRRect(borderRadius: radius, child: ad),
        );
      },
    );
  }
}
