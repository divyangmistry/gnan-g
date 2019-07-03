import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:GnanG/UI/game/answer_response_dialog.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/current_stat.dart';
import '../../Service/apiservice.dart';
import '../../model/question.dart';

class SimpleGame extends StatefulWidget {
  final int level;
  SimpleGame({this.level = 1});
  @override
  State<StatefulWidget> createState() {
    return new SimpleGameState(level);
  }
}

class SimpleGameState extends State<SimpleGame> {
  int correctAnsCounter = 0;
  int wrongAnsCounter = 0;
  int totalAnswers = 1;
  bool isGivenCorrectAns = false;
  int correctAnsIndex = -1;
  int selectedAnsIndex = -1;
  Map<dynamic, dynamic> _userData;
  List<Question> questions;
  Question question;
  int currentQueIndex;
  ApiService _api = new ApiService();
  CurrentState currentState;
  bool isCompletedLevel = false;
  SimpleGameState(int level) {
    _loadAllQuestions(level);
  }

  _loadAllQuestions(int level) {
    currentState = CacheData.userState.currentState;
    _api
        .getQuestions(level: level, from: 0, to: currentState.totalQuestions)
        .then((res) {
      setState(() {
        if (res.statusCode == 200) {
          String questionList = res.body;
          print(utf8.decode(res.bodyBytes));
          List<dynamic> d1 = json.decode(questionList);
          questions = d1.map((queJson) => Question.fromJson(queJson)).toList();
          print(questions);
          question = questions.getRange(0, 1).first;
          currentQueIndex = 0;
        } else {
          //_showError(json.decode(res.body)['msg'], true);
        }
      });
    });
  }

  _reInit() {
    isGivenCorrectAns = false;
    correctAnsIndex = -1;
    selectedAnsIndex = -1;
  }

  void _onOptionSelect(index) {
    setState(() {
      correctAnsIndex = question.answerIndex;
      selectedAnsIndex = index;
      if (selectedAnsIndex == correctAnsIndex) {
        isGivenCorrectAns = true;
        correctAnsCounter = correctAnsCounter + 1;
      } else {
        isGivenCorrectAns = false;
        wrongAnsCounter = wrongAnsCounter + 1;
      }
      totalAnswers = totalAnswers + 1;

      if (currentQueIndex == questions.length - 1) isCompletedLevel = true;
      _dialogBox(isGivenCorrectAns, isCompletedLevel);
    });
  }

  _dialogBox(bool isSelectedAnsCorrect, bool isCompletedLevel) {
    AnswerResponseDialog.getAnswerResponseDialog(isSelectedAnsCorrect: isSelectedAnsCorrect, doneButtonFn: onOKButtonClick);
  }
  void onOKButtonClick(bool isCompletedLevel) {
    Navigator.pop(context);
    setState(() {
      if (!isCompletedLevel) {
        _reInit();
        _loadNextQuestion();
      } else {
        Navigator.pushReplacementNamed(context, '/level');
      }
    });
  }

  _loadNextQuestion() {
    if (currentQueIndex < questions.length - 1) {
      currentQueIndex++;
      question = questions.getRange(currentQueIndex, currentQueIndex + 1).first;
    } else {}

    //question = Question(tempQue, "MCQ", "This is " + tempQue.toString() + " Question", options, answerIndex);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: _appBarView(),
      body: _bodyView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: isGivenCorrectAns ? Colors.green : Colors.red,
      onPressed: () => debugPrint("yo"),
      child: new Icon(Icons.chevron_right),
    );
  }
  _appBarView() {
    return new AppBar(
      title: new Text('Score here!'),
      centerTitle: true,
      leading: new BackButton(),
      actions: <Widget>[
        new PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: new Text('option 1'),
              ),
              PopupMenuItem(
                child: new Text('option 2'),
              )
            ];
          },
        )
      ],
    );
  }

  _bodyView() {
    if (question == null) {
      return Container();
    }
    return new Container(
      padding: EdgeInsets.only(top: 30.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: (selectedAnsIndex == -1)
                ? [
                    Colors.blueGrey,
                    Colors.blueGrey,
                    Colors.blueGrey,
                    Colors.blueGrey
                  ]
                : (isGivenCorrectAns
                    ? [Colors.green, Colors.green, Colors.green, Colors.green]
                    : [Colors.red, Colors.red, Colors.red, Colors.red]),
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter),
      ),
      child: new Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        margin: EdgeInsets.all(20.0),
        child: new ListView(
          // verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            new Center(
              child: new Text(
                "QUESTION " + question.questionSt.toString(),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            new Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 2.5,
              padding: EdgeInsets.all(20.0),
              child: new Center(
                child: new Text(
                  question.question,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            new Container(
              height: MediaQuery.of(context).size.height / 3.1,
              // alignment: Alignment.bottomCenter,
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  return _getOptionWidget(index);
                },
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 50.0),
            ),
          ],
        ),
      ),
    );
  }

  _getOptionWidget(index) {
    return new Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      color: selectedAnsIndex == index
          ? selectedAnsIndex == correctAnsIndex ? Colors.green : Colors.red
          : null,
      child: new ListTile(
        leading: new CircleAvatar(
          child: new Text('$index'),
        ),
        title:
            new Text(question.options.getRange(index, index + 1).first.option),
        onTap: () => _onOptionSelect(index),
      ),
    );
  }
}