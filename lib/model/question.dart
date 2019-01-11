import 'option.dart';
class Question {
  int questionSt;
  String questionType;
  String question;
  List<Options> options;
  int score;
  int level;
  int answer;

  Question(
      {this.questionSt,
        this.questionType,
        this.question,
        this.options,
        this.score,
        this.level,
        this.answer});

  Question.fromJson(Map<String, dynamic> json) {
    questionSt = json['question_st'];
    questionType = json['question_type'];
    question = json['question'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    score = json['score'];
    level = json['level'];
    String ansStr = json['answer'];
    for(final option in options) {
      if (option.option == ansStr) {
        answer = option.optionNumber;
        break;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_st'] = this.questionSt;
    data['question_type'] = this.questionType;
    data['question'] = this.question;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['score'] = this.score;
    data['level'] = this.level;
    data['answer'] = this.answer;
    return data;
  }

  @override
  String toString() {
    return 'Question{questionSt: $questionSt, questionType: $questionType, question: $question, options: $options, score: $score, level: $level, answer: $answer}';
  }


}