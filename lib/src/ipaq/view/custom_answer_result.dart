import 'package:research_package/model.dart';

class CustomAnswerResult extends RPResult {
  final dynamic answer;

  CustomAnswerResult({
    required String identifier,
    this.answer,
  }) : super(identifier: identifier);
}
