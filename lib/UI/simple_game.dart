import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/apiservice.dart';

class SimpleGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SimpleGameState();
  }
}

class SimpleGameState extends State<SimpleGame> {
  int totalWrongHearts = 0;
  bool correctColor = false;
  bool initColor = true;
  int _value;
  int correctAnsCounter = 0;
  int wrongAnsCounter = 0;
  int totalAnswers = 1;
  Map<dynamic, dynamic> _userData;
  List<bool> colorChangeAnswer = [false, false, false, false];
  ApiService _api = new ApiService();

  SimpleGameState() {
    SharedPreferences.getInstance().then((localstorage) {
      _userData = json.decode(localstorage.getString('user_info'));
      print('USER DATA : ');
      print(_userData);
      setState(() {
        totalWrongHearts = _userData['user_info']['lives'];
      });
    });
  }

  int correctAnsIndex = -1;
  int selectedAnsIndex = -1;
  void _correctAnswer(index) {
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      _value = rng.nextInt(4);
    }
    setState(() {
      correctAnsIndex = _value;
      selectedAnsIndex = index;
    });

    if (index == _value) {
      setState(() {
        correctColor = true;
        initColor = false;
        correctAnsCounter = correctAnsCounter + 1;
        totalAnswers = totalAnswers + 1;
        // colorChangeAnswer[index] = true;
      });
      // return _dialogBox(correctColor);
    } else {
      setState(() {
        correctColor = false;
        initColor = false;
        wrongAnsCounter = wrongAnsCounter + 1;
        totalAnswers = totalAnswers + 1;
        if (totalWrongHearts >= 1) {
          totalWrongHearts = totalWrongHearts - 1;
          // colorChangeAnswer[index] = false;
          // return _dialogBox(correctColor);
        } else
          return _gameOverDialogBox();
      });
    }
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
                    icon: correctColor
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : Icon(Icons.close, color: Colors.red),
                    label: new Text('OK!',
                        style: TextStyle(
                            color: correctColor ? Colors.green : Colors.red)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/login');
                      setState(() {
                        initColor = true;
                        correctColor = false;
                      });
                    }),
              ],
            ),
          );
        });
  }

  void _dialogBox(correctColor) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            title: new Text(
              correctColor ? 'Success!' : 'LOL !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: correctColor ? Colors.green : Colors.red,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800),
            ),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                    correctColor
                        ? 'You gave correct answer!'
                        : 'You gave wrong answer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 20.0),
                new FlatButton.icon(
                    icon: correctColor
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : Icon(Icons.close, color: Colors.red),
                    label: new Text(correctColor ? 'OK!' : 'Try Again!',
                        style: TextStyle(
                            color: correctColor ? Colors.green : Colors.red)),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        initColor = true;
                        correctColor = false;
                      });
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: _appBarView(),
      body: _bodyView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: correctColor ? Colors.green : Colors.red,
        onPressed: () => debugPrint("yo"),
        child: new Icon(Icons.chevron_right),
      ),
      bottomNavigationBar: BottomAppBar(
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
                  itemCount: totalWrongHearts,
                  itemBuilder: (context, index) {
                    return new Icon(Icons.healing);
                  },
                ),
              )
            ],
          ),
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
    return new Container(
      padding: EdgeInsets.only(top: 30.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: initColor
                ? [
                    Colors.blueGrey,
                    Colors.blueGrey,
                    Colors.blueGrey,
                    Colors.blueGrey
                  ]
                : (correctColor
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
                "QUESTION $totalAnswers",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25.0,
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
                  'Are you ready to role ?',
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
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _optionsList(index);
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

  _optionsList(index) {
    return new Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      /*color: initColor == false
          ? colorChangeAnswer[index] == true ? Colors.green : Colors.red
          : null,*/
      color: selectedAnsIndex == index
          ? selectedAnsIndex == correctAnsIndex ? Colors.green : Colors.red
          : null,
      child: new ListTile(
        leading: new CircleAvatar(
          child: new Text('$index'),
        ),
        title: new Text('Option $index'),
        onTap: () => _correctAnswer(index),
      ),
    );
  }
}
