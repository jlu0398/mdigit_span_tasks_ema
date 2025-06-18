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
  dynamic _currentAnswer;

  void _nextStep() {
    final currentStep = widget.task.steps[_currentStepIndex];

    final stepResult = CustomAnswerResult(
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
          backgroundColor: const Color.fromARGB(255, 217, 217, 217)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (step is RPInstructionStep) ...[
              Text(
                step.detailText ?? '',
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.left,
              ),
            ] else if (step is RPQuestionStep &&
                step.answerFormat is DurationAnswerFormat) ...[
              Text(
                step.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
              CustomRPUIDateTimeQuestionBody(
                key: ValueKey(step.identifier),
                answerFormat: step.answerFormat as DurationAnswerFormat,
                onResultChange: (val) {
                  setState(() => _currentAnswer = val);
                },
              ),
            ] else if (step is RPQuestionStep &&
                step.answerFormat is wheel.WheelAnswerFormat) ...[
              Text(
                step.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
              wheel.WheelQuestionBody(
                answerFormat: step.answerFormat as wheel.WheelAnswerFormat,
                onResultChange: (val) {
                  setState(() {
                    _currentAnswer = val;
                  });
                },
              ),
            ],
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
