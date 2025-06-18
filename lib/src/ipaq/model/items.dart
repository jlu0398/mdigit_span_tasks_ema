import 'package:research_package/research_package.dart';
import 'package:mdigits/src/ipaq/view/duration_answer_format.dart';

final RPQuestionStep ipaq_1 = RPQuestionStep(
  identifier: "ipaq_vigorous",
  title:
      "¿Cuánto tiempo dedicaste hoy a realizar actividades físicas vigorosas?",
  answerFormat: DurationAnswerFormat(),
);

final RPQuestionStep ipaq_2 = RPQuestionStep(
  identifier: "ipaq_moderate",
  title:
      "¿Cuánto tiempo dedicaste hoy a realizar actividades físicas moderadas?",
  answerFormat: DurationAnswerFormat(),
);

final RPQuestionStep ipaq_3 = RPQuestionStep(
  identifier: "ipaq_walk",
  title: "¿Cuánto tiempo dedicaste hoy a caminar?",
  answerFormat: DurationAnswerFormat(),
);

final RPQuestionStep ipaq_4 = RPQuestionStep(
  identifier: "ipaq_seated",
  title: "¿Cuánto tiempo estuviste hoy sentado?",
  answerFormat: DurationAnswerFormat(),
);

final List<RPStep> ipaqSteps = [
  RPInstructionStep(
    identifier: 'ipaq_instrucions',
    title: 'Actividad Física',
    detailText:
        'A continuación responderás algunas preguntas sobre la clase de actividad física que realizaste hoy.\n\nPor favor, responde a cada pregunta aún si no te consideras una persona activa.\n\nPor favor, piensa en aquellas actividades que haces como parte del trabajo, en el jardín y en la casa, para ir de un sitio a otro, y en tu tiempo libre de descanso, ejercicio o deporte.',
  ),
  ipaq_1,
  ipaq_2,
  ipaq_3,
  ipaq_4,
];
