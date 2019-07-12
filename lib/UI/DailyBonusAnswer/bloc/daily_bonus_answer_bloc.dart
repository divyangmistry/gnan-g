import 'dart:async';
import 'package:GnanG/UI/DailyBonusAnswer/resources/repository.dart';
import 'package:GnanG/model/daily_bonus_answer.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final _repository = Repository();
  
  final _dailyBonusAnswerFetcher = BehaviorSubject<DailyBonusAnswer>();

  Observable<DailyBonusAnswer> get dailyBonusAnswer => _dailyBonusAnswerFetcher.stream;

  Future getDailyBonusAnswer(DateTime date) async {
    print('Date is $date');
    DailyBonusAnswer dailyBonusAnswer = await _repository.getDailyBonusAnswers(date: date);
    _dailyBonusAnswerFetcher.sink.add(dailyBonusAnswer);
  }

  void dispose() {
    _dailyBonusAnswerFetcher.close();
  }

}

final bloc = Bloc();