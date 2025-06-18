import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:research_package/model.dart';

class WheelAnswerFormat extends RPAnswerFormat {
  final List<int> choices;

  WheelAnswerFormat({required this.choices});
}

class WheelQuestionBody extends StatefulWidget {
  final WheelAnswerFormat answerFormat;
  final Function(dynamic) onResultChange;

  const WheelQuestionBody({
    Key? key,
    required this.answerFormat,
    required this.onResultChange,
  }) : super(key: key);

  @override
  State<WheelQuestionBody> createState() => _WheelQuestionBodyState();
}

class _WheelQuestionBodyState extends State<WheelQuestionBody> {
  void _feedback() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CupertinoPicker(
        itemExtent: 50,
        useMagnifier: true,
        magnification: 1.6,
        squeeze: 1,
        scrollController: FixedExtentScrollController(initialItem: 0),
        selectionOverlay: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.25),
          ),
        ),
        onSelectedItemChanged: (index) {
          widget.onResultChange(widget.answerFormat.choices[index]);
          _feedback();
        },
        children: List.generate(
          widget.answerFormat.choices.length,
          (index) => Center(
            child: Text(
              widget.answerFormat.choices[index].toString(),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
