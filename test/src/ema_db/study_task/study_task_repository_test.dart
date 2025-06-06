import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mdigits/src/core/ema_db/datasources/firebase_datasource.dart';
import 'package:mdigits/src/core/ema_db/study_task/models/metadata/metadata.dart';
import 'package:mdigits/src/core/ema_db/study_task/models/survey/survey.dart';
import 'package:mdigits/src/core/ema_db/study_task/models/survey/survey_item.dart';
import 'package:mdigits/src/core/ema_db/study_task/study_task_repository.dart';

import '../test_data/remote_datasource.dart';
import '../test_data/metadata.dart';
import '../test_data/survey.dart';

void main() {
  late StudyTaskRepository repository;
  late FirebaseDataSource firebaseDataSource;

  setUp((() {
    firebaseDataSource = FirebaseDataSource(db: FakeFirebaseFirestore());
    repository = StudyTaskRepository(remoteDataSource: firebaseDataSource);
  }));

  test(
    "Given a [StudyTask] and [path], [saveStudyTask] should save the task's "
    "metadata and items to the db.",
    () async {
      final Survey expectedSurvey = Survey(
        metadata: expectedMetadata,
        items: testSurveyItems,
      );

      await repository.save(
        studyTask: expectedSurvey,
        path: docRefPath,
      );

      final String basePath =
          '$docRefPath/sessions/${expectedMetadata.sessionID}';

      /// assert metadata
      final QuerySnapshot<Map<String, dynamic>> metadataSnapshot =
          await firebaseDataSource.db.collection('$basePath/metadata').get();
      final Metadata actualMetadata =
          Metadata.fromJson(metadataSnapshot.docs.first.data());
      expect(actualMetadata, expectedMetadata);

      /// assert items
      final QuerySnapshot<Map<String, dynamic>> itemsSnapshot =
          await firebaseDataSource.db.collection('$basePath/items').get();
      final List<SurveyItem> actualItems = itemsSnapshot.docs.map((item) {
        return SurveyItem.fromJson(item.data());
      }).toList();
      expect(actualItems, testSurveyItems);

      /// assert study task
      final actualSurvey = Survey(
        metadata: actualMetadata,
        items: actualItems,
      );
      expect(actualSurvey, expectedSurvey);
    },
  );
}
