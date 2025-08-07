import 'package:mdigits/src/ipaq/view/duration_answer_format.dart';
import 'package:research_package/research_package.dart';

class IPAQQuestion {
  final String identifier;
  final String title;

  const IPAQQuestion(this.identifier, this.title);
}

const List<IPAQQuestion> _questions = [
  IPAQQuestion(
    'ipaq_vigorous',
    '¿Cuánto tiempo dedicaste hoy a realizar actividades físicas vigorosas?',
  ),
  IPAQQuestion(
    'ipaq_moderate',
    '¿Cuánto tiempo dedicaste hoy a realizar actividades físicas moderadas?',
  ),
  IPAQQuestion(
    'ipaq_walk',
    '¿Cuánto tiempo dedicaste hoy a caminar?',
  ),
  IPAQQuestion(
    'ipaq_seated',
    '¿Cuánto tiempo estuviste hoy sentado?',
  ),
];

final List<RPStep> ipaqSteps = [
  RPInstructionStep(
    identifier: 'ipaq_instrucions',
    title: 'Actividad Física',
    detailText:
        'A continuación responderás algunas preguntas sobre la clase de actividad física que realizaste hoy.\n\nPor favor, responde a cada pregunta aún si no te consideras una persona activa.\n\nPor favor, piensa en aquellas actividades que haces como parte del trabajo, en el jardín y en la casa, para ir de un sitio a otro, y en tu tiempo libre de descanso, ejercicio o deporte.',
  ),
  ..._questions.map(
    (q) => RPQuestionStep(
      identifier: q.identifier,
      title: q.title,
      answerFormat: DurationAnswerFormat(),
    ),
  ),
];

