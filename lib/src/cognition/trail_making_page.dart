import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart' as rp;
import 'package:cognition_package/cognition_package.dart' as cog;

class TrailMakingPage extends StatelessWidget {
  const TrailMakingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final task = _buildTrailMakingTask();

    return Scaffold(
      appBar: AppBar(title: const Text('Trail Making')),
      body: SafeArea(
        child: rp.RPUITask(
          task: task,
          onSubmit: (rp.RPTaskResult result) {
            debugPrint('Trail result => ${result.results}');
            Navigator.of(context).pop(result);
          },
        ),
      ),
    );
  }

  rp.RPOrderedTask _buildTrailMakingTask() {
    final intro = rp.RPInstructionStep(
      identifier: 'tmt_intro',
      title: 'Prueba de Senderos (Trail Making) - Tipo B',
      text: 'Verás círculos con números y letras. Toca alternando en orden: '
          '1, A, 2, B, 3, C, … hasta completar la secuencia.\n\n'
          'Si te equivocas, la app te avisará y podrás corregir.',
    );

    final trailStep = cog.RPTrailMakingActivity(
      identifier: 'tmt_b',
      trailType: cog.TrailType.B,
      includeInstructions: false,
      includeResults: true,
    );

    final completion = rp.RPCompletionStep(
      identifier: 'tmt_done',
      title: 'Completado',
      text: '¡Gracias! Has terminado la prueba de senderos.',
    );

    return rp.RPOrderedTask(
      identifier: 'trail_making_task_b',
      steps: [
        intro,
        trailStep,
        completion,
      ],
    );
  }
}
