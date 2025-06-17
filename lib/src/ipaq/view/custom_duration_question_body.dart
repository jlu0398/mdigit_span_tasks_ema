import 'package:flutter/material.dart';
import 'custom_duration_picker.dart';
import 'duration_answer_format.dart';

class CustomRPUIDateTimeQuestionBody extends StatefulWidget {
  final DurationAnswerFormat answerFormat;
  final void Function(Duration) onResultChange;

  const CustomRPUIDateTimeQuestionBody({
    Key? key,
    required this.answerFormat,
    required this.onResultChange,
  }) : super(key: key);

  @override
  State<CustomRPUIDateTimeQuestionBody> createState() =>
      _CustomRPUIDateTimeQuestionBodyState();
}

class _CustomRPUIDateTimeQuestionBodyState
    extends State<CustomRPUIDateTimeQuestionBody> {
  Duration _duration = const Duration(hours: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: CustomDurationPicker(
        initialDuration: _duration,
        maxHours: widget.answerFormat.maxHours,
        maxMinutes: widget.answerFormat.maxMinutes,
        onDurationChanged: (newDuration) {
          setState(() => _duration = newDuration);
          widget.onResultChange(newDuration);
        },
      ),
    );
  }
}
