import 'package:GnanG/model/current_stat.dart';
import 'package:GnanG/model/quizlevel.dart';

class UserState {
  List<QuizLevel> quizLevels;
  List<CompletedLevel> completed;
  // CurrentState currentState;
  int totalscore;
  int totalscore_month;
  int totalscore_week;
  int lives;

  UserState({this.quizLevels,
    this.completed,
    // this.currentState,
    this.totalscore,
    this.totalscore_month,
    this.totalscore_week,
    this.lives
  });

  UserState.fromJson(Map<String, dynamic> json) {
    if (json['quiz_levels'] != null) {
      quizLevels = new List<QuizLevel>();
      json['quiz_levels'].forEach((v) {
        quizLevels.add(new QuizLevel.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = new List<CompletedLevel>();
      json['completed'].forEach((v) {
        completed.add(new CompletedLevel.fromJson(v));
      });
    }
    // if (json['current'] != null && json['current'][0] != null) {
    //   currentState = new CurrentState.fromJson(json['current'][0]);
    // }
    totalscore = json['totalscore'];
    totalscore_month = json['totalscore_month'];
    totalscore_week = json['totalscore_week'];
    lives = json['lives'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quizLevels != null) {
      data['quiz_levels'] = this.quizLevels.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed.map((v) => v.toJson()).toList();
    }
    // if (this.current != null) {
    //   data['current'] = this.current.map((v) => v.toJson()).toList();
    // }
    data['totalscore'] = this.totalscore;
    data['totalscore_month'] = this.totalscore_month;
    data['totalscore_week'] = this.totalscore_week;
    data['lives'] = this.lives;
    return data;
  }

  // @override
  // String toString() {
  //   return 'CompletedLevel{quizLevels: $quizLevels, completed: $completed, current: $currentState, totalscore: $totalscore, lives: $lives}';
  // } ---> ORIGINAL <----
  @override
  String toString() {
    return 'CompletedLevel{ totalscore: $totalscore, lives: $lives}';
  }
}

class CompletedLevel {
  int level;
  int score;

  CompletedLevel({this.level, this.score});

  CompletedLevel.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['score'] = this.score;
    return data;
  }

  @override
  String toString() {
    return 'CompletedLevel{level: $level, score: $score}';
  }
}
