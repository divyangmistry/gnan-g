class ValidateQuestion {
  bool answerStatus;
  int lives;
  int totalscore;

  ValidateQuestion({this.answerStatus, this.lives, this.totalscore});

  ValidateQuestion.fromJson(Map<String, dynamic> json) {
    answerStatus = json['answer_status'];
    lives = json['lives'];
    totalscore = json['totalscore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_status'] = this.answerStatus;
    data['lives'] = this.lives;
    data['totalscore'] = this.totalscore;
    return data;
  }
}