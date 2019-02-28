import 'option.dart';
class Question {
  String questionType;
  int score;
  String quizType;
  int questionId;
  int questionSt;
  String question;
  List<Options> options;
  List<Answer> answer;
  int answerIndex;
  String artifactPath;
  int level;
  String date;
  String reference;
  List<String> jumbledata;
  int iV;
  PikacharAnswer pikacharAnswer;

  Question(
      {this.questionType,
        this.score,
        this.quizType,
        this.questionId,
        this.questionSt,
        this.question,
        this.options,
        this.answer,
        this.artifactPath,
        this.level,
        this.date,
        this.reference,
        this.jumbledata,
        this.iV});

  static List<Question> fromJsonArray(List<dynamic> json) {
    return json.map((dynamic model)=> Question.fromJson(model)).toList();
  }

  void setAnswerIndex() {
    if(answer.isNotEmpty) {
      int index = 0;
      options.forEach((option) {
        if(option.option == answer.first.answer) {
          answerIndex = index;
        }
        index++;
      });
    }
  }
  Question.fromJson(Map<String, dynamic> json) {
    questionType = json['question_type'];
    score = json['score'];
    quizType = json['quiz_type'];
    questionId = json['question_id'];
    questionSt = json['question_st'];
    question = json['question'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    List<List> words = new List<List>();
    if (json['pikacharanswer'] != null) {
      json['pikacharanswer'].forEach((v) {
         List<String> chars = List.from(v);
         print(chars);
         words.add(chars);
      });
      print(words);
      pikacharAnswer = PikacharAnswer(answer: words);
    }

    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
    setAnswerIndex();
    artifactPath = json['artifact_path'];
    level = json['level'];
    date = json['date'];
    reference = json['reference'];
    if (json['jumbledata'] != null) {
      jumbledata = new List<String>();
      json['jumbledata'].forEach((v) {
          jumbledata.add(v);
      });
    }
    iV = json['__v'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_type'] = this.questionType;
    data['score'] = this.score;
    data['quiz_type'] = this.quizType;
    data['question_id'] = this.questionId;
    data['question_st'] = this.questionSt;
    data['question'] = this.question;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    data['artifact_path'] = this.artifactPath;
    data['level'] = this.level;
    data['date'] = this.date;
    data['reference'] = this.reference;
    if (this.jumbledata != null) {
      //data['jumbledata'] = this.jumbledata.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }

  @override
  String toString() {
    return 'Question{questionType: $questionType, score: $score, quizType: $quizType, questionId: $questionId, questionSt: $questionSt, question: $question, options: $options, answer: $answer, artifactPath: $artifactPath, level: $level, date: $date, reference: $reference, jumbledata: $jumbledata, iV: $iV}';
  }


}
class Answer {
  String sId;
  String answer;

  Answer({this.sId, this.answer});

  Answer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['answer'] = this.answer;
    return data;
  }

  @override
  String toString() {
    return 'Answer{answer: $answer}';
  }

}

class PikacharAnswer {
  List<List> answer;

  PikacharAnswer({this.answer});

  PikacharAnswer.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['_id'] = this.sId;
//    data['answer'] = this.answer;
//    return data;
//  }

  @override
  String toString() {
    return 'Answer{answer: $answer}';
  }

}