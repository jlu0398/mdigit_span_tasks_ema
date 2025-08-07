import 'package:research_package/model.dart';

class CustomAnswerResult<T> extends RPResult {
  final T? answer;

  CustomAnswerResult({
    required String identifier,
    this.answer,
  }) : super(identifier: identifier);
}
