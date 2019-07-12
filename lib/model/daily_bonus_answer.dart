class DailyBonusAnswer {
  String question;
  String answer;

  DailyBonusAnswer({this.question, this.answer});

  DailyBonusAnswer.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}