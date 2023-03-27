import 'package:auto_size_text/auto_size_text.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/material.dart';

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
  })  : assert(title != null && title.isNotEmpty),
        assert(subtitle != null && subtitle.isNotEmpty),
        assert(mainBtnTitle != null && mainBtnTitle.isNotEmpty),
        assert(mainBtnCallback != null),
        super(key: key);

  @override
  _EyeHelperAlertDialogState createState() => _EyeHelperAlertDialogState();
}

class _EyeHelperAlertDialogState extends State<EyeHelperAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Container(
                      height: 20,
                    ),
                    AutoSizeText(
                      widget.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Theme.of(context).primaryColorDark,
                          ),
                    ),
                    Container(
                      height: 12,
                    ),
                    Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Container(
                      height: 20,
                    ),
                    RoundCustomButton(
                      parentSize: MediaQuery.of(context).size,
                      onPressed: widget.mainBtnCallback,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: AutoSizeText(
                          widget.mainBtnTitle,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                    if (widget.secondaryBtnCallback != null &&
                        widget.secondaryBtnTitle != null &&
                        widget.secondaryBtnTitle!.isNotEmpty) ...[
                      Container(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              height: 48,
                              onPressed: () => widget.secondaryBtnCallback!(),
                              child: Text(
                                widget.secondaryBtnTitle!,
                                style: Theme.of(context).textTheme.button?.copyWith(
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 4,
                      )
                    ] else
                      Container(
                        height: 20,
                      )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
