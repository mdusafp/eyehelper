import 'package:eyehelper/app_id.dart';
import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/helpers/firebase_analytics.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/screens/notification_screen/sheet_scaffold.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// "Do you like the app?" — yes asks for a store review, no asks what is
/// wrong. Either answer hides the card for a good while; it comes back only
/// once that time has passed.
class FeedbackCard extends StatefulWidget {
  const FeedbackCard({super.key, required this.onAnswered});

  /// Fired the moment either button is tapped, so the host can drop the card
  /// and give the accent back to its own button.
  final VoidCallback onAnswered;

  static const Duration _hideAfterYes = Duration(days: 365);
  static const Duration _hideAfterNo = Duration(days: 150);

  /// Whether the card is due — false while a previous answer still counts.
  static bool get isDue {
    final prefs = FastPreferences();
    if (!prefs.isInited) {
      return false;
    }
    final until = prefs.prefs.getInt(FastPreferences.feedbackHiddenUntil);
    return until == null || DateTime.now().millisecondsSinceEpoch >= until;
  }

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  bool _answered = false;

  /// TEMP: answers are not persisted while the card is being tested, so it
  /// comes back on every visit. Flip to false before release.
  static const bool _debugNeverHide = true;

  Future<void> _hideFor(Duration duration) async {
    if (_debugNeverHide) {
      return;
    }
    await FastPreferences().prefs.setInt(
          FastPreferences.feedbackHiddenUntil,
          DateTime.now().add(duration).millisecondsSinceEpoch,
        );
  }

  Future<void> _yes() async {
    setState(() => _answered = true);
    widget.onAnswered();
    await _hideFor(FeedbackCard._hideAfterYes);
    AppAnalytics().sendEvent('app_feedback', params: {'liked': 'yes'});
    // The system decides whether the review dialog actually appears; either
    // way there is nothing more to do here.
    try {
      final review = InAppReview.instance;
      if (await review.isAvailable()) {
        await review.requestReview();
      }
    } catch (e) {
      debugPrint('Review request failed: $e');
    }
  }

  Future<void> _no() async {
    setState(() => _answered = true);
    widget.onAnswered();
    await _hideFor(FeedbackCard._hideAfterNo);
    if (!mounted) {
      return;
    }
    final text = await showAppSheet<String>(
      context,
      builder: (context) => const _FeedbackSheet(),
    );
    AppAnalytics().sendEvent('app_feedback', params: {
      'liked': 'no',
      // Analytics caps a parameter at 100 characters; the full text goes by mail.
      'text':
          (text ?? '').length > 100 ? text!.substring(0, 100) : (text ?? ''),
    });
    if (text != null && text.trim().isNotEmpty) {
      await _sendByMail(text.trim());
    }
  }

  Future<void> _sendByMail(String text) async {
    if (kFeedbackEmail.isEmpty) {
      return;
    }
    final subject = Uri.encodeComponent('Eye Helper feedback');
    final body = Uri.encodeComponent(text);
    final uri = Uri.parse('mailto:$kFeedbackEmail?subject=$subject&body=$body');
    try {
      await launchUrl(uri);
    } catch (e) {
      // No mail client — the analytics event above already carries the gist.
      debugPrint('Could not open mail client: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_answered) {
      return const SizedBox.shrink();
    }
    final t = context.t.finish;
    return Stack(
      children: [
        AppCard(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          child: Column(
            children: [
              Text(
                t.likeQuestion,
                textAlign: TextAlign.center,
                style: appText(16, weight: FontWeight.w600),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _Answer(label: t.likeNo, accent: false, onTap: _no),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _Answer(label: t.likeYes, accent: true, onTap: _yes),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Share sits in the card's very corner, outside the text flow.
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => SharePlus.instance.share(ShareParams(
                text: context.t.finish.shareText(url: getAppUrl()))),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.ios_share, size: 20, color: appAccentDeep),
            ),
          ),
        ),
      ],
    );
  }
}

class _Answer extends StatelessWidget {
  final String label;
  final bool accent;
  final VoidCallback onTap;

  const _Answer(
      {required this.label, required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: accent ? EyehelperColorScheme.activeColor : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: accent
            ? BorderSide.none
            : const BorderSide(color: appHairline, width: 1.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: SizedBox(
          height: 44,
          child: Center(
            child: Text(
              label,
              style: appText(
                15,
                weight: FontWeight.w600,
                color: accent ? Colors.white : EyehelperColorScheme.mainDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Free-text "what could be better", returned through the sheet's result.
class _FeedbackSheet extends StatefulWidget {
  const _FeedbackSheet();

  @override
  State<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<_FeedbackSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.finish;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetTitle(t.feedbackTitle),
        Text(
          t.feedbackHint,
          textAlign: TextAlign.center,
          style:
              appText(13, color: EyehelperColorScheme.lightGrey, height: 1.35),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _controller,
          autofocus: true,
          minLines: 3,
          maxLines: 6,
          textCapitalization: TextCapitalization.sentences,
          style: appText(15),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF1F5F2),
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 14),
        Center(
          child: Opacity(
            opacity: _controller.text.trim().isEmpty ? 0.5 : 1,
            child: RoundCustomButton(
              parentSize: MediaQuery.of(context).size,
              onPressed: () {
                if (_controller.text.trim().isEmpty) {
                  return;
                }
                Navigator.of(context).pop(_controller.text);
              },
              child: Text(t.feedbackSend,
                  style: Theme.of(context).textTheme.labelLarge),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.feedbackSkip,
              style: appText(14, color: EyehelperColorScheme.lightGrey)),
        ),
      ],
    );
  }
}
