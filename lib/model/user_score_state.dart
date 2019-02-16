import 'package:GnanG/model/cacheData.dart';

class UserScoreState {
  int lives;
  int totalscore;

  UserScoreState({this.lives, this.totalscore});

  UserScoreState.fromJson(Map<String, dynamic> json) {
    lives = json['lives'];
    totalscore = json['totalscore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lives'] = this.lives;
    data['totalscore'] = this.totalscore;
    return data;
  }

  @override
  String toString() {
    return 'UserScoreState{lives: $lives, totalscore: $totalscore}';
  }

  updateSessionScore() {
    if(lives != null)
      CacheData.userState.lives = lives;
    if(totalscore != null)
      CacheData.userState.totalscore = totalscore;
  }

}