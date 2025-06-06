import 'package:mdigits/src/core/ema_db/progress/models/study_progress_step.dart';
import 'package:mdigits/src/core/ema_db/progress/models/status.dart';

final DateTime dateTime = DateTime.now();
final StudyProgressStep testProgressStep = StudyProgressStep(
  participantId: 'id',
  stepId: 'consentStep',
  completionDateTime: dateTime,
  stepDescription: 'Consent step description',
  lastUpdatedDateTime: dateTime,
  status: Status.completed,
);
