import 'package:flutter/material.dart';
import 'package:mdigits/src/ipaq/view/wheel_answer_format.dart' as wheel;
import 'package:research_package/model.dart';
import 'custom_duration_question_body.dart';
import 'duration_answer_format.dart';
import 'custom_answer_result.dart';

class CustomTaskWidget extends StatefulWidget {
  final RPOrderedTask task;
  final void Function(RPTaskResult) onSubmit;

  const CustomTaskWidget({
    Key? key,
    required this.task,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<CustomTaskWidget> createState() => _CustomTaskWidgetState();
}

class _CustomTaskWidgetState extends State<CustomTaskWidget> {
  int _currentStepIndex = 0;
  final RPTaskResult _taskResult = RPTaskResult(identifier: 'custom_task');
  Object? _currentAnswer;

  void _nextStep() {
    final currentStep = widget.task.steps[_currentStepIndex];

    final stepResult = CustomAnswerResult<Object?>(
      identifier: currentStep.identifier,
      answer: _currentAnswer,
    );
    _taskResult.setStepResultForIdentifier(currentStep.identifier, stepResult);
    _currentAnswer = null;

    if (_currentStepIndex + 1 >= widget.task.steps.length) {
      widget.onSubmit(_taskResult);
    } else {
      setState(() {
        _currentStepIndex++;
      });
    }
  }

  void _previousStep() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
        _currentAnswer = null;
      });
    }
  }

  Widget _buildStepWidget(RPStep step) {
    if (step is RPInstructionStep) {
      return _InstructionStep(step: step);
    } else if (step is RPQuestionStep &&
        step.answerFormat is DurationAnswerFormat) {
      return _DurationQuestionStep(
        step: step,
        onChanged: (val) => setState(() => _currentAnswer = val),
      );
    } else if (step is RPQuestionStep &&
        step.answerFormat is wheel.WheelAnswerFormat) {
      return _WheelQuestionStep(
        step: step,
        onChanged: (val) => setState(() => _currentAnswer = val),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.task.steps[_currentStepIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          step is RPInstructionStep
              ? step.title
              : 'Pregunta $_currentStepIndex',
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStepWidget(step),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentStepIndex > 0 ? _previousStep : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 115, 115),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Atrás',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        (step is RPInstructionStep || _currentAnswer != null)
                            ? _nextStep
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 128, 244, 82),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Continuar',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final RPInstructionStep step;
  const _InstructionStep({required this.step});

  @override
  Widget build(BuildContext context) {
    return Text(
      step.detailText ?? '',
      style: const TextStyle(fontSize: 25),
      textAlign: TextAlign.left,
    );
  }
}

class _DurationQuestionStep extends StatelessWidget {
  final RPQuestionStep step;
  final ValueChanged<Object?> onChanged;

  const _DurationQuestionStep({
    required this.step,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          textAlign: TextAlign.left,
        ),
        CustomRPUIDateTimeQuestionBody(
          key: ValueKey(step.identifier),
          answerFormat: step.answerFormat as DurationAnswerFormat,
          onResultChange: onChanged,
        ),
      ],
    );
  }
}

class _WheelQuestionStep extends StatelessWidget {
  final RPQuestionStep step;
  final ValueChanged<Object?> onChanged;

  const _WheelQuestionStep({
    required this.step,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          textAlign: TextAlign.left,
        ),
        wheel.WheelQuestionBody(
          answerFormat: step.answerFormat as wheel.WheelAnswerFormat,
          onResultChange: onChanged,
        ),
      ],
    );
  }
}
