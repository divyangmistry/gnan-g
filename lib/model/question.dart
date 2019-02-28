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
  PikacharAnswer pikacharAnswer;
  int answerIndex;
  String artifactPath;
  int level;
  String date;
  String reference;
  List<Null> jumbledata;
  int iV;

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
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
    PikacharAnswer pikacharAnswer = PikacharAnswer();

    if (json['pikacharanswer'] != null) {
      List pikacharanswer = new List<List<String>>();
      json['pikacharanswer'].forEach((v) {
        List abc = new List<String>();
        v.forEach((w) {
          abc.add(w);
        });
        pikacharanswer.add(abc);
        this.pikacharAnswer = PikacharAnswer.fromJson(pikacharanswer);
      });
    }
//    if (json['pikacharanswer'] != null) {
//      pikacharAnswer = new PikacharAnswer.fromJson(json['pikacharanswer']);
//    }
    setAnswerIndex();
    artifactPath = json['artifact_path'];
    level = json['level'];
    date = json['date'];
    reference = json['reference'];
    if (json['jumbledata'] != null) {
      jumbledata = new List<Null>();
      json['jumbledata'].forEach((v) {
        //jumbledata.add(new Null.fromJson(v));
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
  List<List<String>> answer;

  PikacharAnswer({this.answer});

  PikacharAnswer.fromJson(List json) {
    answer = json;
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