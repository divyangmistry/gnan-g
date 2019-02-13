import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/colors.dart';
import '../../common.dart';
import '../../colors.dart';

List<String> _optionChars = [];
AnswerTiles ansTiles;
Map _answerChars = {
  "length": 6,
  "indexToInsert": 0,
  0: " ",
  1: " ",
  2: " ",
  3: " ",
  4: " ",
  5: " ",
};

class Pikachar extends StatefulWidget {
  @override
  _PikacharState createState() => new _PikacharState();
}

class _PikacharState extends State<Pikachar> {
  @override
  void initState() {
    super.initState();
    _optionChars = ['સિ', 'મં', 'ધ', 'ર', 'સ્વા', 'મી'];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ansTiles = new AnswerTiles();
    return new Container(
        child: Scaffold(
          body: new BackgroundGredient(
              child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      question(),
                      ansTiles,
                      optionTilesOne(),
                      optionTilesTwo(),
                    ],
                  ))),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              //TODO: Implement submit
            },
            icon: Icon(Icons.done),
            label: Text('SUBMIT'),
          ),
        )
    );
  }

  Widget question() {
    return new Container(
      padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
      child: Text(
        'This is a Pikachar style question where you tap on character tiles?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kQuizBackgroundWhite,
        ),
        textScaleFactor: 2,
      ),
    );
  }

  Widget answerTiles() {
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Row(
          children: <Widget>[
            answerTile(),
            answerTile(),
            answerTile(),
            answerTile(),
            answerTile(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
    );
  }

  Widget answerTile() {
    return new Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: SizedBox(
        width: 40,
        height: 70,
      ),
      color: kQuizMain400,
    );
  }

  Widget optionTilesOne() {
    return new Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: createOptionTiles(),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  Widget optionTilesTwo() {
    return new Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          optionTile('દા', 0),
          optionTile('દા', 1),
          optionTile('ભ', 2),
          optionTile('ગ', 3),
          optionTile('વા', 4),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  List<StatefulWidget> createOptionTiles() {
    List<StatefulWidget> opTiles = List<StatefulWidget>();
    for (int i = 0; i < _optionChars.length; i++) {
      var opTile = new OptionTile(i, _optionChars[i]);
      opTiles.add(opTile);
    }
    return opTiles;
  }

  Widget optionTile(String text, int index) {
    return new GestureDetector(
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                text,
                textScaleFactor: 3,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
        )
    );
  }
}

class OptionTile extends StatefulWidget {
  int index;
  String char;

  OptionTile(this.index, this.char);

  _OptionTileState createState() => _OptionTileState(this.index, this.char);
}

class _OptionTileState extends State<OptionTile> {
  int index;
  String char;
  bool isActive = false;

  _OptionTileState(this.index, this.char);

  void rtrnCharFromAnswer() {
    setState(() {
      isActive = false;
    });
  }

  void tileTapped() {
    if (!isActive) {
      // TODO: Call method of answerChars to add char
      if (ansTiles.addCharToAnswer(char, index)) {
        setState(() {
          // TODO: Convert OptionTile to a statefulwidget so changes in the state
          // reflect on UI.
          isActive = true;
        });
      }
    }
  }

  Widget getWidget() {
    return new GestureDetector(
        onTap: tileTapped,
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                this.char,
                textScaleFactor: 3,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          color: isActive ? kQuizMain50 : kQuizBackgroundWhite,
        )
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
        onTap: tileTapped,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              this.char,
              textScaleFactor: 3,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          color: isActive ? kQuizMain50 : kQuizBackgroundWhite,
        )
    );
  }
}

class AnswerTiles extends StatefulWidget {
  _AnswerTilesState st;

  _AnswerTilesState createState() {
    st = new _AnswerTilesState();
    return st;
  }

  bool addCharToAnswer(String char, int index) {
    return st.addChar(char, index);
  }
}

class _AnswerTilesState extends State<AnswerTiles> {
  bool addChar(char, index) {
    // TODO: Check if the answer tiles are full, if yes then just return false
    int i = _answerChars["indexToInsert"];
    setState(() {
      _answerChars["indexToInsert"]++;
      _answerChars[i] = char;
    });
    return true;
  }

  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Row(
          children: createAnswerTiles(),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
    );
  }

  createAnswerTiles() {
    List<StatefulWidget> opTiles = List<StatefulWidget>();
    for (int i = 0; i < _answerChars["length"]; i++) {
      var opTile = new AnswerTile(i);
      opTiles.add(opTile);
    }
    return opTiles;
  }
}

class AnswerTile extends StatefulWidget {
  int index;

  AnswerTile(this.index);

  _AnswerTileState createState() => new _AnswerTileState(this.index);
}

class _AnswerTileState extends State<AnswerTile> {
  String char = "દા";
  int index;
  int indexOfOption;

  _AnswerTileState(this.index);

  void answerTileTapped() {
    // TODO: Implement tile tapped function
    // 1. Return the char to index of option
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: answerTileTapped,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            _answerChars[index],
            textScaleFactor: 3,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kQuizSurfaceWhite
            ),
          ),
        ),
        color: kQuizMain400,
      ),
    );
  }
}