import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class EyeHelperAlertDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String mainBtnTitle;
  final String? secondaryBtnTitle;
  final Function mainBtnCallback;
  final Function? secondaryBtnCallback;

  EyeHelperAlertDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.mainBtnTitle,
    this.secondaryBtnTitle,
    required this.mainBtnCallback,
    this.secondaryBtnCallback,
  })  : assert(title.isNotEmpty),
        assert(subtitle.isNotEmpty),
        assert(mainBtnTitle.isNotEmpty),
        super(key: key);

  @override
  _EyeHelperAlertDialogState createState() => _EyeHelperAlertDialogState();
}

class _EyeHelperAlertDialogState extends State<EyeHelperAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return GlassDialog(
      title: widget.title,
      message: widget.subtitle,
      actions: [
        GlassDialogAction(
          label: widget.mainBtnTitle,
          isPrimary: true,
          onPressed: () => widget.mainBtnCallback(),
        ),
        if (widget.secondaryBtnCallback != null &&
            (widget.secondaryBtnTitle ?? '').isNotEmpty)
          GlassDialogAction(
            label: widget.secondaryBtnTitle!,
            onPressed: () => widget.secondaryBtnCallback!(),
          ),
      ],
    );
  }
}
