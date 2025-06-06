import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mdigits/src/auth/participant.dart';
import 'package:mdigits/src/core/ema_db/datasources/firebase_datasource.dart';
import 'package:mdigits/src/core/ema_db/study_task/models/metadata/metadata.dart';
import 'package:mdigits/src/core/ema_db/study_task/models/survey/survey.dart';
import 'package:mdigits/src/core/ema_db/study_task/models/survey/survey_item.dart';
import 'package:mdigits/src/core/ema_db/study_task/study_task_repository.dart';
import 'package:mdigits/src/surveys/data/survey_item_data.dart';
import 'package:research_package/research_package.dart';

import '../surveys/data/survey_data.dart';

/// Format demographics data and stores in db.
void processDemographicsData(RPTaskResult results) {
  final SurveyData surveyData = SurveyData.fromRPTaskResult(
    rpSurveyData: results,
    description: 'Demographics survey',
  );
  final Participant participant = Get.find();
  final String participantID = participant.id;
  final String sessionID = surveyData.startTime.toString();

  final Metadata metadata = Metadata(
    participantID: participantID,
    sessionID: sessionID,
    startTime: surveyData.startTime,
    endTime: surveyData.endTime,
    description: surveyData.description,
    identifier: surveyData.identifier,
  );

  final Iterable<SurveyItem> surveyItems =
      surveyData.items.map((SurveyItemData item) {
    final SurveyItem surveyItem = SurveyItem(
      participantID: participantID,
      sessionID: sessionID,
      startTime: item.startTime,
      endTime: item.endTime,
      identifier: item.identifier,
      description: item.description,
      type: item.type,
      response: item.response,
      choices: item.choices,
    );
    return surveyItem;
  });

  final Survey survey = Survey(
    metadata: metadata,
    items: surveyItems.toList(),
  );

  final FirebaseDataSource remoteDataSource = FirebaseDataSource(
    db: FirebaseFirestore.instance,
  );
  final StudyTaskRepository studyTaskRepository = StudyTaskRepository(
    remoteDataSource: remoteDataSource,
  );

  final String path = 'surveys/participants/$participantID/demographics';
  studyTaskRepository.save(
    studyTask: survey,
    path: path,
  );
}
