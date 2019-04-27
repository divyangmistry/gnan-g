import 'package:GnanG/model/cacheData.dart';

class ValidateQuestion {
  bool answerStatus;
  int lives;
  int totalscore;
  int questionSt;
  int questionReadSt;

  ValidateQuestion({this.answerStatus, this.lives, this.totalscore});

  ValidateQuestion.fromJson(Map<String, dynamic> json) {
    answerStatus = json['answer_status'];
    lives = json['lives'];
    totalscore = json['totalscore'];
    questionSt = json['question_st'];
    questionReadSt = json['question_read_st'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_status'] = this.answerStatus;
    data['lives'] = this.lives;
    data['totalscore'] = this.totalscore;
    data['question_st'] = this.questionSt;
    data['question_read_st'] = this.questionReadSt;
    return data;
  }

  updateSessionScore() {
    if (lives != null) CacheData.userState.lives = lives;
    if (totalscore != null) CacheData.userState.totalscore = totalscore;
    if (questionSt != null)
      CacheData.userState.currentState.questionSt = questionSt;
    if (questionReadSt != null)
      CacheData.userState.currentState.questionReadSt = questionReadSt;
  }
}
