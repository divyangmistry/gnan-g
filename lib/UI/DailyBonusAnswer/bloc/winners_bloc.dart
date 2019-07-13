import 'dart:async';
import 'package:GnanG/UI/DailyBonusAnswer/resources/repository.dart';
import 'package:GnanG/model/leaders.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final _repository = Repository();
  
  final _winnerFetcher = BehaviorSubject<LeaderList>();

  Observable<LeaderList> get winnerList => _winnerFetcher.stream;

  Future getWinnerList() async {
    try {
    LeaderList winnerlist = await _repository.getLastMonthWinners();
    _winnerFetcher.sink.add(winnerlist);
    } catch (e) {
      _winnerFetcher.sink.addError(e);
    }
  }

  void dispose() {
    _winnerFetcher.close();
  }

}

final bloc = Bloc();