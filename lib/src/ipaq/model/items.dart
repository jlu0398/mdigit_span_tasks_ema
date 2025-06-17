import 'package:research_package/research_package.dart';
import 'package:mdigits/src/ipaq/view/duration_answer_format.dart';
import 'package:mdigits/src/ipaq/view/wheel_answer_format.dart';

final RPQuestionStep ipaq_1 = RPQuestionStep(
  identifier: "ipaq_1",
  title:
      "Durante los últimos 7 días, ¿Cuántos días realizó usted actividades físicas vigorosas como levantar objetos pesados, excavar, aeróbicos, o pedalear rápido en bicicleta? ",
  answerFormat: WheelAnswerFormat(choices: [0, 1, 2, 3, 4, 5, 6, 7]),
);

final RPQuestionStep ipaq_2 = RPQuestionStep(
  identifier: "ipaq_2",
  title:
      "¿Cuánto tiempo en total usualmente le tomó realizar actividades físicas vigorosas en uno de esos días que las realizó?",
  answerFormat: DurationAnswerFormat(),
);

final RPQuestionStep ipaq_3 = RPQuestionStep(
  identifier: "ipaq_3",
  title:
      "Durante los últimos 7 días, ¿Cuántos días hizo usted actividades físicas moderadas tal como cargar objetos livianos,  pedalear en bicicleta a paso regular, o  jugar dobles de tenis? No incluya caminatas.",
  answerFormat: WheelAnswerFormat(choices: [0, 1, 2, 3, 4, 5, 6, 7]),
);

final RPQuestionStep ipaq_4 = RPQuestionStep(
  identifier: "ipaq_4",
  title:
      "Usualmente, ¿Cuánto tiempo dedica usted en uno de esos días haciendo actividades físicas moderadas?",
  answerFormat: DurationAnswerFormat(),
);

final RPQuestionStep ipaq_5 = RPQuestionStep(
  identifier: "ipaq_5",
  title:
      "Durante los últimos 7 días, ¿Cuántos días caminó usted por al menos 10 minutos continuos?",
  answerFormat: WheelAnswerFormat(choices: [0, 1, 2, 3, 4, 5, 6, 7]),
);

final RPQuestionStep ipaq_6 = RPQuestionStep(
  identifier: "ipaq_6",
  title:
      "Usualmente, ¿Cuánto tiempo gastó usted en uno de esos días caminando?",
  answerFormat: DurationAnswerFormat(),
);

final RPQuestionStep ipaq_7 = RPQuestionStep(
  identifier: "ipaq_7",
  title:
      "Durante los últimos 7 días, ¿Cuánto tiempo permaneció sentado(a) en un día en la semana?",
  answerFormat: DurationAnswerFormat(),
);

final List<RPStep> ipaqSteps = [
  RPInstructionStep(
    identifier: 'intro',
    title: 'IPAQ',
    detailText:
        'Estamos interesados en saber acerca de la clase de actividad física que la gente hace como parte de su vida diaria. Las preguntas se referirán acerca del tiempo que usted utilizó siendo físicamente activo(a) en los últimos 7 días. Por favor responda cada pregunta aún si usted no se considera una persona activa. Por favor piense en aquellas actividades que usted hace como parte del trabajo, en el jardín y en la casa, para ir de un sitio a otro, y en su tiempo libre de descanso, ejercicio o deporte.',
  ),
  ipaq_1,
  ipaq_2,
  ipaq_3,
  ipaq_4,
  ipaq_5,
  ipaq_6,
  ipaq_7,
];
