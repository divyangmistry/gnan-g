import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/model/CacheData.dart';
import 'package:kon_banega_mokshadhipati/model/current-stat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/apiservice.dart';
import '../model/question.dart';
class SimpleGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SimpleGameState();
  }
}

class SimpleGameState extends State<SimpleGame> {
  int userLives = 3;
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
  SimpleGameState() {
    /*SharedPreferences.getInstance().then((localstorage) {
      _userData = json.decode(localstorage.getString('user_info'));
      print('USER DATA : ');
      print(_userData);
      setState(() {
        totalWrongHearts = _userData['user_info']['lives'];
      });
    });*/
    userLives = CacheData.userSession.currentStat.lives;
    _loadAllQuestions();
  }

  _loadAllQuestions() {
    currentState = CacheData.userSession.currentStat;
    _api.getQuestions(currentState.level,currentState.queSt,currentState.totalQues).then((res) {
      setState(() {
        if (res.statusCode == 200) {
          String questionList = res.body;
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
      correctAnsIndex = question.answer - 1;
      selectedAnsIndex = index;
      if (selectedAnsIndex == correctAnsIndex) {
        isGivenCorrectAns = true;
        correctAnsCounter = correctAnsCounter + 1;
      } else {
        isGivenCorrectAns = false;
        wrongAnsCounter = wrongAnsCounter + 1;
        if (userLives >= 1) {
          userLives = userLives - 1;
        } else
          return _gameOverDialogBox();
      }
      totalAnswers = totalAnswers + 1;
      bool isCompletedLevel = false;
      if(currentQueIndex == questions.length -1)
        isCompletedLevel = true;
      _dialogBox(isGivenCorrectAns, isCompletedLevel);
    });
  }

  void _gameOverDialogBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            title: new Text(
              'Game Over',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800),
            ),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text('You are done ... GO HOME !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 20.0),
                new FlatButton.icon(
                    icon: isGivenCorrectAns
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : Icon(Icons.close, color: Colors.red),
                    label: new Text('OK!',
                        style: TextStyle(
                            color: isGivenCorrectAns ? Colors.green : Colors.red)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/login');
                      setState(() {
                        isGivenCorrectAns = false;
                      });
                    }),
              ],
            ),
          );
        });
  }

  void _dialogBox(isSelectedAnsCorrect, isCompletedLevel) {
    String msg = "";
    if(isCompletedLevel) {
      msg = "Level " + currentState.level.toString() + " is Completed";
    } else {
      if(isSelectedAnsCorrect)
        msg = "You gave correct answer";
      else
        msg = "You gave wrong answer";
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            title: new Text(
              isSelectedAnsCorrect ? 'Success!' : 'LOL !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelectedAnsCorrect ? Colors.green : Colors.red,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800),
            ),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 20.0),
                new FlatButton.icon(
                    icon: isSelectedAnsCorrect
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : Icon(Icons.close, color: Colors.red),
                    label: new Text('Next',
                        style: TextStyle(
                            color: isSelectedAnsCorrect ? Colors.green : Colors.red)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        if(!isCompletedLevel) {
                          _reInit();
                          _loadNextQuestion();
                        }

                      });
                    }),
              ],
            ),
          );
        });
  }

  _loadNextQuestion() {
    if(currentQueIndex < questions.length - 1) {
      currentQueIndex++;
      question = questions.getRange(currentQueIndex, currentQueIndex + 1).first;
    } else {

    }

    //question = Question(tempQue, "MCQ", "This is " + tempQue.toString() + " Question", options, answerIndex);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: _appBarView(),
      body: _bodyView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomBar(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: isGivenCorrectAns ? Colors.green : Colors.red,
      onPressed: () => debugPrint("yo"),
      child: new Icon(Icons.chevron_right),
    );
  }

  _bottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: new Container(
        height: 50.0,
        child: new Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.center,
              child: new Text(
                "Correct Answer's : $correctAnsCounter",
                style: TextStyle(color: Colors.green, fontSize: 15.0),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width / 2,
              child: new ListView.builder(
                padding: EdgeInsets.only(left: 60.0),
                scrollDirection: Axis.horizontal,
                itemCount: userLives,
                itemBuilder: (context, index) {
                  return new Icon(Icons.healing);
                },
              ),
            )
          ],
        ),
      ),
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
    if(question == null) {
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
                "QUESTION " + question.index.toString(),
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
                  question.text,
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
        title: new Text(question.options.getRange(index, index + 1).first.option),
        onTap: () => _onOptionSelect(index),
      ),
    );
  }
}
