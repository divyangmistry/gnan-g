import 'package:SheelQuotient/model/current_stat.dart';
import 'package:SheelQuotient/model/quizlevel.dart';

class UserState {

  List<QuizLevel> quizLevels;
  List<CompletedLevel> completed;
  CurrentState currentStat;

  UserState({this.quizLevels, this.completed, this.currentStat});

  UserState.fromJson(Map<String, dynamic> json) {
    if (json['quiz_levels'] != null) {
      quizLevels = new List<QuizLevel>();
      json['quiz_levels'].forEach((v) {
        print(v);
        quizLevels.add(new QuizLevel.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = new List<CompletedLevel>();
      json['completed'].forEach((v) {
        completed.add(new CompletedLevel.fromJson(v));
      });
    }
    if (json['current'] != null) {
      List<CurrentState> currents = new List<CurrentState>();
      json['current'].forEach((v) {
        currents.add(new CurrentState.fromJson(v));
      });
      if(currents.isNotEmpty)
        currentStat = currents.first;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quizLevels != null) {
      data['quiz_levels'] = this.quizLevels.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed.map((v) => v.toJson()).toList();
    }
/*    if (this.current != null) {
      data['current'] = this.current.map((v) => v.toJson()).toList();
    }*/
    return data;
  }

  @override
  String toString() {
    return 'UserState{quizLevels: $quizLevels, completed: $completed, current: $currentStat}';
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