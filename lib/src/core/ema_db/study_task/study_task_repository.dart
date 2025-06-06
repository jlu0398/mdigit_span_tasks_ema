import 'package:mdigits/src/core/ema_db/datasources/firebase_datasource.dart';
import 'package:mdigits/src/core/ema_db/datasources/remote_datasource.dart';
import 'package:mdigits/src/core/ema_db/study_task/models/study_task.dart';

/// Provides a simple interface for managing [StudyTask] data.
class StudyTaskRepository {
  final RemoteDataSource _remoteDataSource;

  StudyTaskRepository({required FirebaseDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  /// Adds [studyTask] data to the db in the specified [path].
  ///
  /// Stores the [studyTask.metadata] in [path]/metadata and [studyTask.items]
  /// in [path]/items.
  /// [path] must be a valid path that can be used to create a firebase
  /// document.
  Future<void> save({
    required StudyTask studyTask,
    required String path,
  }) async {
    final String basePath = '$path/sessions/${studyTask.metadata.sessionID}';
    await _remoteDataSource.saveEMAModel(
      emaModel: studyTask.metadata,
      path: '$basePath/metadata',
    );
    await _remoteDataSource.saveEMAModels(
      emaModels: studyTask.items,
      path: '$basePath/items',
    );
  }
}
