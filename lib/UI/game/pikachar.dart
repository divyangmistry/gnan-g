import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/colors.dart';
import '../../common.dart';
import '../../colors.dart';

List<String> _optionChars = [];
int rowTilesLimit = 6; // What is the max no. of tiles in a row
AnswerTiles ansTiles;
List<OptionTile> opTiles = List<OptionTile>();
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
    // todo: Set the optionChars to come from API
    _optionChars = [
      'સી', 'મં', 'ધ', 'ર', 'સ્વા', 'મી', 'દા', 'દા', 'ભ', 'ગ', 'વા',
      'ન', 'ની', 'રૂ', 'મા'
    ];
  }

  @override
  Widget build(BuildContext context) {
    ansTiles = new AnswerTiles();
    return new Container(
      child: Scaffold(
        body: new BackgroundGredient(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                question(),
                ansTiles,
                optionTiles(),
              ],
            ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //TODO: Implement submit
            //TODO: Submit button should be inactive till all answer tiles are full
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
      ));
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

  Widget optionTiles() {
    return new Column(
      children: createOptionRows(),
    );
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
      padding: EdgeInsets.all(20),
      child: Row(
        children: createOptionTiles(i),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  List<StatefulWidget> createOptionTiles(int startingIndex) {
    List<OptionTile> tempOpTiles = List<OptionTile>();
    for (int i = startingIndex; i < _optionChars.length &&
      i < startingIndex + rowTilesLimit; i++) {
      var opTile = new OptionTile(i, _optionChars[i]);
      opTiles.add(opTile);
      tempOpTiles.add(opTile);
    }
    return tempOpTiles;
  }

  Widget optionTile(String text, int index) {
    return new GestureDetector(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
  _OptionTileState st;

  OptionTile(this.index, this.char);

  void rtrnCharFromAnswer() {
    st.rtrnCharFromAnswer();
  }

  _OptionTileState createState() {
    st = _OptionTileState(this.index, this.char);
    return st;
  }
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
      if (ansTiles.addCharToAnswer(char, index)) {
        setState(() {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
    return new GestureDetector(
      onTap: tileTapped,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
  //todo: @Milan: Please check, is calling methods of state from statefulwidget
  // the correct way, because setState can only be called from State.
  // Or is there another way? I had to hack it this way as I didn't know any
  // other way. This is not working with hot reload, the state becomes null.
  _AnswerTilesState st;

  _AnswerTilesState createState() {
    st = new _AnswerTilesState();
    return st;
  }

  /// Set the index to insert to the first blank answer tile
  /// Needs to be called after removing or adding an answer tile
  void findIndexToInsert() {
    for (int i = 0; i < _answerChars["length"]; i++) {
      if (_answerChars[i] == "" || _answerChars[i] == " ") {
        _answerChars["indexToInsert"] = i;
        break;
      }
    }
  }

  /// Adds the char to the answer tiles
  bool addCharToAnswer(String char, int opTileIndex) {
    return st.addChar(char, opTileIndex);
  }
}

class _AnswerTilesState extends State<AnswerTiles> {
  List<AnswerTile> aTiles;

  bool addChar(char, opTileIndex) {
    int i = _answerChars["indexToInsert"];
    if (i >= _answerChars["length"]) {
      return false;
    } else {
      aTiles[i].setOpIndex(i, char, opTileIndex);
    }
    ansTiles.findIndexToInsert();
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
    aTiles = List<AnswerTile>();
    for (int i = 0; i < _answerChars["length"]; i++) {
      var opTile = new AnswerTile(i);
      aTiles.add(opTile);
    }
    return aTiles;
  }
}

class AnswerTile extends StatefulWidget {
  int index;
  _AnswerTileState st;

  AnswerTile(this.index);

  void setOpIndex(int i, String char, int opTileIndex) {
    st.setOpIndex(i, char, opTileIndex);
  }

  _AnswerTileState createState() {
    st = new _AnswerTileState(this.index);
    return st;
  }
}

class _AnswerTileState extends State<AnswerTile> {
  String char = "દા";
  int index;
  int indexOfOption;

  _AnswerTileState(this.index);

  void setOpIndex(int i, String char, int opTileIndex) {
    this.indexOfOption = opTileIndex;
    setState(() {
      _answerChars["indexToInsert"]++;
      _answerChars[i] = char;
    });
  }

  void answerTileTapped() {
    if (indexOfOption != null) {
      opTiles[indexOfOption].rtrnCharFromAnswer();
      indexOfOption = null;
      setState(() {
        _answerChars[index] = " ";
      });
      ansTiles.findIndexToInsert();
    }
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
              fontWeight: FontWeight.bold, color: kQuizSurfaceWhite),
          ),
        ),
        color: kQuizMain400,
      ),
    );
  }
}
