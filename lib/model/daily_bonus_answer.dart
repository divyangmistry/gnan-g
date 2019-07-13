import 'package:GnanG/model/question.dart';

class DailyBonusAnswer {
  String question;
  List<Answer> answer;

  DailyBonusAnswer({this.question, this.answer});

  DailyBonusAnswer.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}