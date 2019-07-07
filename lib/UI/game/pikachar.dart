import 'dart:math';

import 'package:GnanG/model/question.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class Pikachar extends StatefulWidget {
  String questText;
  List<String> optionChars;
  PikacharAnswer answer;
  Function validateAnswer;

  Pikachar(this.questText, this.optionChars, this.answer, this.validateAnswer);

  @override
  _PikacharState createState() {
    return new _PikacharState();
  }
}

class _PikacharState extends State<Pikachar> {
  List<bool> isActiveArr = new List<bool>();
  List<int> ansOptionMapping = new List<int>();
  List<String> _optionChars = [];
  List answerLengths = List();
  String questionText =
      'This is a Pikachar style question where you tap on character tiles?';
  int rowTilesLimit = 6; // What is the max no. of tiles in a row
  List<Widget> aTiles = List<Widget>();
  List opTiles = List();
  Map _answerChars = new Map();
  ScrollController scrollController = new ScrollController();

  _PikacharState() {
    print("State restarted");
  }

  @override
  void initState() {
    scrollToTop();
    super.initState();
  }

  scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget != null &&
        !ListEquality().equals(widget.optionChars, this._optionChars)) {
      initializeQuestion(widget.answer, widget.optionChars);
    }

    return new ListView(
      controller: scrollController,
      children: <Widget>[
        question(),
        answerRows(),
        optionTiles(),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
        )
      ],
    );
  }

  int getLengthOfAnswerChars(List answer) {
    return answer.fold(0, (t, e) => t + e.length);
  }

  List mapAnswerCharsToLength(List answer) {
    return answer.map((a) => a.length).toList();
  }

  void setAnswerCharsFromData(PikacharAnswer ans) {
    print("reset answer chars");
    int lengthOfAnswer = getLengthOfAnswerChars(ans.answer);
    answerLengths = mapAnswerCharsToLength(ans.answer);
    print(lengthOfAnswer);
    print("answerLengths: " + answerLengths.toString());
    _answerChars['length'] = lengthOfAnswer;
    _answerChars['indexToInsert'] = 0;

    for (int i = 0; i < lengthOfAnswer; i++) {
      _answerChars[i] = " ";
    }
  }

  void initializeQuestion(var ans, optionChars) {
    isActiveArr.clear();
    ansOptionMapping.clear();
    _answerChars.clear();
    aTiles = List<Widget>();
    opTiles = List();
    setAnswerCharsFromData(ans);

    print("initialize:" + ans.toString());

    for (int i = 0; i < optionChars.length; i++) {
      isActiveArr.add(false);
    }

    for (int i = 0; i < _answerChars['length']; i++) {
      ansOptionMapping.add(null);
    }

    print(isActiveArr);

    // todo: Set the optionChars to come from API
    if (optionChars != null) {
      print("initialize:" + optionChars.toString());
      _optionChars = optionChars;
    } else {
      _optionChars = [
        'સી',
        'મં',
        'ધ',
        'ર',
        'સ્વા',
        'મી',
        'દા',
        'દા',
        'ભ',
        'ગ',
        'વા',
        'ન',
        'ની',
        'રૂ',
        'મા'
      ];
    }
  }

  Widget question() {
    return new Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Text(
        widget.questText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Gujarati',
          color: kQuizMain400,
        ),
        textScaleFactor: 2,
      ),
    );
  }

  Widget optionTiles() {
    return optionRow(0);
  }

  List<Widget> createOptionRows() {
    List<Widget> cols = new List<Widget>();
    for (int i = 0; i < _optionChars.length; i = i + rowTilesLimit) {
      var optRow = optionRow(i);
      cols.add(optRow);
    }
    return cols;
  }

  Widget optionRow(int i) {
    return Container(
//        padding: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 15,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        children: createOptionTiles(i),
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  List<Widget> createOptionTiles(int startingIndex) {
    List<Widget> tempOpTiles = List();
    for (int i = startingIndex;
        i < _optionChars.length
//      && i < startingIndex + rowTilesLimit
        ;
        i++) {
      var opTile = optionTileButton(i, _optionChars[i]);
      opTiles.add(opTile);
      tempOpTiles.add(opTile);
    }
    return tempOpTiles;
  }

  Widget optionTileButton(int index, String char) {
    return new MaterialButton(
      onPressed: !isActiveArr[index]
          ? () {
              if (addCharToAnswer(char, index)) {
                setState(() {
                  isActiveArr[index] = true;
                });
              }
            }
          : null,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      disabledColor: kQuizMain400,
      disabledElevation: 0,
      minWidth: 50.0,
      height: 50.0,
      color: kQuizMain400,
      child: Text(
        char,
        style: TextStyle(
          fontFamily: 'Gujarati',
        ),
        textScaleFactor: 1.3,
      ),
    );
  }

  Widget optionTile(int index, String char) {
    return new GestureDetector(
      onTap: () {
        print(isActiveArr);
        if (!isActiveArr[index]) {
          if (addCharToAnswer(char, index)) {
            setState(() {
              isActiveArr[index] = true;
            });
          }
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            char,
            textScaleFactor: 2,
            style:
                TextStyle(fontFamily: 'Gujarati', fontWeight: FontWeight.bold),
          ),
        ),
        color: isActiveArr[index] ? kQuizMain50 : kQuizBackgroundWhite,
      ),
    );
  }

  Widget answerRows() {
    print("answerRows");
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: new Column(
        children: createAnswerRows(),
      ),
    );
  }

  List<Widget> createAnswerRows() {
    print("new list");
    List<Widget> cols = new List<Widget>();
//    for (int i = 0; i < _answerChars["length"]; i = i + rowTilesLimit) {
    int i = 0;
    for (int j = 0; j < answerLengths.length; j++) {
      int temp = answerLengths[j];
      while (temp > 0) {
        int numTilesInRow = min(rowTilesLimit, temp);
        var optRow = answerTiles(i, numTilesInRow);
        cols.add(optRow);
        i += numTilesInRow;
        temp -= numTilesInRow;
      }
    }
    return cols;
  }

  void findIndexToInsert() {
    int i = 0;
    for (; i < _answerChars["length"]; i++) {
      if (_answerChars[i] == "" || _answerChars[i] == " ") {
        break;
      }
    }
    // If all tiles full, then indexToInsert set to length + 1
    _answerChars["indexToInsert"] = i;
  }

  bool addCharToAnswer(String char, int opTileIndex) {
    int i = _answerChars["indexToInsert"];
    if (i >= _answerChars["length"]) {
      return false;
    } else {
      setOpIndex(i, char, opTileIndex);
    }
    findIndexToInsert();
    if (shouldAnswerBeSubmitted(_answerChars["indexToInsert"])) {
      checkAnswer();
    }
    return true;
  }

  void setOpIndex(int i, String char, int opTileIndex) {
    print(i.toString() + char + opTileIndex.toString());
    ansOptionMapping[i] = opTileIndex;
    setState(() {
      print("Hi");
      _answerChars["indexToInsert"]++;
      _answerChars[i] = char;
    });
  }

  bool shouldAnswerBeSubmitted(int indexToInsert) {
    return indexToInsert >= _answerChars["length"];
  }

  Widget answerTiles(int startingIndex, int numTiles) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        children: createAnswerTiles(startingIndex, numTiles),
        runAlignment: WrapAlignment.spaceAround,
        alignment: WrapAlignment.spaceAround,
        spacing: 10,
        runSpacing: 10,
      ),
    );
  }

  List<Widget> createAnswerTiles(int startingIndex, int numTiles) {
    print("new answertiles created");
    List<Widget> tempAnswerTiles = new List<Widget>();
    for (int i = startingIndex;
        i < _answerChars["length"] && i < startingIndex + numTiles;
        i++) {
      var aTile = answerTileButton(i);
      tempAnswerTiles.add(aTile);
      aTiles.add(aTile);
    }
    return tempAnswerTiles;
  }

  Widget answerTileButton(int index) {
    return new MaterialButton(
      onPressed: ansOptionMapping[index] != null
          ? () {
              rtrnCharFromAnswer(ansOptionMapping[index]);
              ansOptionMapping[index] = null;
              setState(() {
                _answerChars[index] = " ";
              });
              findIndexToInsert();
            }
          : null,
      disabledElevation: 0,
      disabledColor: kQuizMain500,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      minWidth: 60.0,
      height: 60.0,
      color: kQuizMain500,
      child: Text(
        _answerChars[index],
        style: TextStyle(
          fontFamily: 'Gujarati',
        ),
        textScaleFactor: 1.5,
      ),
    );
  }

  Widget answerTile(int index) {
    return new GestureDetector(
      onTap: () {
        print("Reached here outside if" + ansOptionMapping[index].toString());
        if (ansOptionMapping[index] != null) {
          print("Reached here");
          rtrnCharFromAnswer(ansOptionMapping[index]);
          ansOptionMapping[index] = null;
          setState(() {
            _answerChars[index] = " ";
          });
          findIndexToInsert();
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            _answerChars[index],
            textScaleFactor: 2,
            style: TextStyle(
                fontFamily: 'Gujarati',
                fontWeight: FontWeight.bold,
                color: kQuizSurfaceWhite),
          ),
        ),
        color: kQuizMain500,
      ),
    );
  }

  void rtrnCharFromAnswer(int indexOfOption) {
    setState(() {
      isActiveArr[indexOfOption] = false;
    });
  }

  // Construct answer from the answer tiles and validate
  void checkAnswer() {
    String userAnswer = "";
    for (int i = 0; i < _answerChars["length"]; i++) {
      userAnswer += _answerChars[i];
    }
    print(userAnswer);
    widget.validateAnswer(answer: userAnswer);
  }
}
