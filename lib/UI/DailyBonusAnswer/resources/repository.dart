import 'dart:async';
import 'package:GnanG/UI/DailyBonusAnswer/resources/daily_bonus_repository.dart';
import 'package:GnanG/model/question.dart';

class Repository {
  final dailyBonusAnswerApiProvider = DailyBonusAnswerProvider();

  Future<List<Question>> getDailyBonusAnswers() =>
      dailyBonusAnswerApiProvider.getDailyBonusAnswer();
}
