import 'package:digit_span_tasks/digit_span_tasks.dart';
import 'package:get/get.dart';
import 'package:mdigits/src/core/navigator_service/navigator_service.dart';
import '../config/config.dart';
import 'package:mdigits/src/ui_components/instructions.dart';
import '../../ui_components/loading_screen.dart';
import '../prep_data.dart';
import 'rest_instructions.dart';

/// Configure and start the DSF
Future<DigitSpanTaskData> runDigitSpanForward() async {
  final DigitSpanTaskConfig config = Get.find();
  Get.to(() => const LoadingScreen());
  await Get.to(
    () => const Instructions(
      instructions:
          InstructionsText('Recuerda los números en el orden en que los veas'),
    ),
  );
  await Get.to(
    () => const Instructions(
        instructions: InstructionsText('Comencemos practicando')),
  );
  DigitSpanTask task;
  final UserConfig userConfigPractice = UserConfig(
    participantID: config.participantID,
    sessionID: config.sessionID,
    sessionType: SessionType.practice,
    restInstructions: const RestInstructions(),
    minStimSize: config.practiceMinStimSize,
    maxStimSize: config.practiceMaxStimSize,
    countEachSize: config.practiceCountEachSize,
  );

  task = DigitSpanTask(
    config: userConfigPractice,
  );
  DigitSpanTaskData practiceData = await task.run();

  await Get.to(
    () => const Instructions(
        instructions: InstructionsText(
            'Ahora trabajaremos con los ejercicios principales')),
  );
  await Get.to(
    () => const Instructions(
        instructions: InstructionsText(
            'Recuerda escribir los números en el orden en que los veas')),
  );

  final UserConfig userConfigExperimental = UserConfig(
    participantID: config.participantID,
    sessionID: config.sessionID,
    sessionType: SessionType.experimental,
    restInstructions: const RestInstructions(),
    minStimSize: config.experimentalMinStimSize,
    maxStimSize: config.experimentalMaxStimSize,
    countEachSize: config.experimentalCountEachSize,
  );

  task = DigitSpanTask(
    config: userConfigExperimental,
  );
  DigitSpanTaskData experimentalData = await task.run();

  final DigitSpanTaskData data = prepData(
    practiceData: practiceData,
    experimentalData: experimentalData,
  );

  await Get.to(() => const Instructions(
      instructions: InstructionsText('¡Terminamos esta actividad!')));

  final NavigatorService navigatorService = Get.find();
  final String nextScreen = await navigatorService.determineNextScreen();
  Get.offAllNamed(nextScreen);
  return data;
}
