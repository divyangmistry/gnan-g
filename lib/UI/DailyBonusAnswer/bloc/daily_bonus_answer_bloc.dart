import 'dart:async';
import 'package:GnanG/UI/DailyBonusAnswer/resources/repository.dart';
import 'package:GnanG/model/question.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final _repository = Repository();
  
  final _dailyBonusAnswerFetcher = BehaviorSubject<List<Question>>();

  Observable<List<Question>> get dailyBonusAnswer => _dailyBonusAnswerFetcher.stream;

  Future getDailyBonusAnswer() async {
    try {
    List<Question> dailyBonusAnswer = await _repository.getDailyBonusAnswers();
    _dailyBonusAnswerFetcher.sink.add(dailyBonusAnswer);
    } catch (e) {
      _dailyBonusAnswerFetcher.sink.addError(e);
    }
  }

  void dispose() {
    _dailyBonusAnswerFetcher.close();
  }

}

final bloc = Bloc();