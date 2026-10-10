import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Delivers "what don't you like" texts to the developer through the shared
/// feedback proxy (the `dglfactor-review-proxy` repository), which holds the
/// Telegram bot token: the app carries no secret.
///
/// Every message goes through a queue kept in preferences. One written
/// offline, or while the proxy is busy, goes out on a later launch; its id
/// stays the same on every try, so the proxy forwards a resent message once.
class FeedbackSender {
  FeedbackSender._();

  static final Uri _endpoint = Uri.parse('https://dglfactor.tech/api/feedback');
  // Must match the proxy's ALLOWED_APPS exactly.
  static const String _appName = 'Eye Helper';
  // The longest text the proxy takes, in code points.
  static const int _textLimit = 3500;
  static const int _diagnosticLimit = 64;
  // A message this old is dropped, delivered or not.
  static const Duration _maximumAge = Duration(days: 30);
  static const String _outboxKey = 'feedback_outbox';

  static Future<void>? _flushing;

  /// Queues [text] and tries to send everything waiting. True once this
  /// message is delivered; false when it is still queued (or was refused).
  static Future<bool> submit(String text, {required String appVersion, required String locale}) async {
    final item = _Item(
      id: _uuid(),
      text: _fitted(text),
      diagnostics: _diagnostics(appVersion: appVersion, locale: locale),
      createdAt: DateTime.now(),
    );
    _save([..._load(), item]);
    await flush();
    return !_load().any((e) => e.id == item.id);
  }

  /// Sends what is waiting, oldest first, until one has to wait. One run at a
  /// time; a second caller waits for it.
  static Future<void> flush() {
    return _flushing ??= _deliverWaiting().whenComplete(() => _flushing = null);
  }

  static Future<void> _deliverWaiting() async {
    final cutoff = DateTime.now().subtract(_maximumAge);
    final items = _load().where((e) => e.createdAt.isAfter(cutoff)).toList();
    _save(items);
    while (items.isNotEmpty) {
      final outcome = await _send(items.first);
      if (outcome == _Outcome.retryLater) {
        // Offline or the proxy is busy: the rest would wait just the same.
        return;
      }
      items.removeAt(0);
      _save(items);
    }
  }

  static Future<_Outcome> _send(_Item item) async {
    try {
      final response = await http
          .post(
            _endpoint,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'app': _appName,
              'text': item.text,
              'diagnostics': item.diagnostics,
              'id': item.id,
            }),
          )
          .timeout(const Duration(seconds: 20));
      final status = response.statusCode;
      if (status >= 200 && status < 300) {
        return _Outcome.sent;
      }
      debugPrint('Feedback: proxy replied $status: ${response.body}');
      // 400, 413, 415: the proxy will never take it. 429, 502 and the rest:
      // try again later.
      return const {400, 404, 413, 415}.contains(status) ? _Outcome.rejected : _Outcome.retryLater;
    } catch (e) {
      // No connection, a timeout: the message stays.
      debugPrint('Feedback: proxy request failed: $e');
      return _Outcome.retryLater;
    }
  }

  static Map<String, String> _diagnostics({required String appVersion, required String locale}) {
    final os = Platform.isIOS ? 'iOS' : (Platform.isAndroid ? 'Android' : Platform.operatingSystem);
    // On iOS this reads "Version 26.2 (Build 23C55)"; keep just the number.
    final rawVersion = Platform.operatingSystemVersion;
    final version = Platform.isIOS
        ? (RegExp(r'\d+(\.\d+)*').firstMatch(rawVersion)?.group(0) ?? rawVersion)
        : rawVersion;
    return {
      'appVersion': _clip(appVersion),
      'system': _clip('$os $version'),
      'language': _clip(locale),
    };
  }

  static String _clip(String value) =>
      value.length > _diagnosticLimit ? value.substring(0, _diagnosticLimit) : value;

  /// Trimmed, and cut with "…" when longer than the proxy takes.
  static String _fitted(String text) {
    final runes = text.trim().runes.toList();
    if (runes.length <= _textLimit) {
      return text.trim();
    }
    return '${String.fromCharCodes(runes.take(_textLimit - 1))}…';
  }

  static String _uuid() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // RFC 4122 variant
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join().toUpperCase();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-'
        '${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  static List<_Item> _load() {
    final prefs = FastPreferences();
    if (!prefs.isInited) {
      return [];
    }
    try {
      final raw = prefs.prefs.getString(_outboxKey);
      if (raw == null) {
        return [];
      }
      return (jsonDecode(raw) as List).map((e) => _Item.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint('Feedback: unreadable outbox dropped: $e');
      return [];
    }
  }

  static void _save(List<_Item> items) {
    final prefs = FastPreferences();
    if (!prefs.isInited) {
      return;
    }
    unawaited(prefs.prefs.setString(_outboxKey, jsonEncode(items.map((e) => e.toJson()).toList())));
  }
}

enum _Outcome { sent, retryLater, rejected }

class _Item {
  final String id;
  final String text;
  final Map<String, String> diagnostics;
  final DateTime createdAt;

  const _Item({required this.id, required this.text, required this.diagnostics, required this.createdAt});

  factory _Item.fromJson(Map<String, dynamic> json) => _Item(
        id: json['id'] as String,
        text: json['text'] as String,
        diagnostics: Map<String, String>.from(json['diagnostics'] as Map),
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'diagnostics': diagnostics,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };
}
