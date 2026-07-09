import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntervalPicker extends StatefulWidget {
  final Duration? startDuration;
  final Duration? endDuration;
  final Function(Duration, Duration)? onChanged;

  const IntervalPicker({
    Key? key,
    this.startDuration,
    this.endDuration,
    this.onChanged,
  }) : super(key: key);

  @override
  _IntervalPickerState createState() => _IntervalPickerState();
}

class _IntervalPickerState extends State<IntervalPicker> {
  int currentStartTimeIndex = 0;
  int currentEndTimeIndex = 0;
  int diff = 0;
  late FixedExtentScrollController startController;
  late FixedExtentScrollController endController;

  @override
  void initState() {
    int initialStart = widget.startDuration?.inHours ?? 0;
    int initialEnd = widget.endDuration?.inHours != null ? widget.endDuration!.inHours - 1 : 0;

    startController = FixedExtentScrollController(initialItem: initialStart);
    endController = FixedExtentScrollController(initialItem: initialEnd - initialStart);

    currentStartTimeIndex = initialStart;
    currentEndTimeIndex = initialEnd - initialStart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(height: 16),
          Text(
            "Выберите интервал, в который вы находитесь на работе",
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: IgnorePointer(
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 40,
                        onSelectedItemChanged: (value) {},
                        children: List.generate(1, (index) => Center(child: Text(""))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 40,
                      scrollController: startController,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          currentStartTimeIndex = value;
                        });
                        endController.animateToItem(
                            min(24 - currentStartTimeIndex - 1, endController.selectedItem),
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut);

                        widget.onChanged?.call(Duration(hours: currentStartTimeIndex),
                            Duration(hours: currentStartTimeIndex + 1 + currentEndTimeIndex));
                      },
                      children: List.generate(24, (index) => Center(child: Text("${index}:00"))),
                    ),
                  ),
                  Expanded(
                    child: IgnorePointer(
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 40,
                        onSelectedItemChanged: (value) {},
                        children: List.generate(1, (index) => Center(child: Text(":"))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 40,
                      scrollController: endController,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          currentEndTimeIndex = value;
                        });
                        widget.onChanged?.call(Duration(hours: currentStartTimeIndex),
                            Duration(hours: currentStartTimeIndex + 1 + currentEndTimeIndex));
                      },
                      children: List.generate(
                          24 - currentStartTimeIndex,
                          (index) =>
                              Center(child: Text("${currentStartTimeIndex + 1 + index}:00"))),
                    ),
                  ),
                  Expanded(
                    child: IgnorePointer(
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 40,
                        onSelectedItemChanged: (value) {},
                        children: List.generate(1, (index) => Center(child: Text(""))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
