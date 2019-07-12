import 'dart:async';
import 'package:GnanG/UI/DailyBonusAnswer/resources/daily_bonus_repository.dart';
import 'package:GnanG/model/daily_bonus_answer.dart';
import 'package:flutter/widgets.dart';

class Repository {
  final dailyBonusAnswerApiProvider = DailyBonusAnswerProvider();

  Future<DailyBonusAnswer> getDailyBonusAnswers({@required DateTime date}) =>
      dailyBonusAnswerApiProvider.getDailyBonusAnswer(date: date);
}
