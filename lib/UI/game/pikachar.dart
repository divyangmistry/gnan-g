import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/colors.dart';
import '../../common.dart';
import '../../colors.dart';

class Pikachar extends StatefulWidget {
  @override
  _PikacharState createState() => new _PikacharState();
}

class _PikacharState extends State<Pikachar> {

  @override
  void initState() {
    super.initState();
    _optionChars = ['સિ', 'મં', 'ધ', 'ર', 'સ્વા', 'મી'];
    _answerChars = ['સિ', 'મં', 'ધ', 'ર', 'સ્વા', 'મી'];
  }

  List<String> _optionChars = [];
  List<String> _answerChars = [];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        child: Scaffold(
          body: new BackgroundGredient(
              child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      question(),
                      answerTiles(),
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

  List<GestureDetector> createOptionTiles() {
    List<GestureDetector> opTiles = List<GestureDetector>();
    for (int i = 0; i < _optionChars.length; i++) {
      var opTile = new OptionTile(i, _optionChars[i]);
      opTiles.add(opTile.getWidget());
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

class OptionTile {
  int index;
  String char;
  bool isActive;

  OptionTile(this.index, this.char);

  void rtrnCharFromAnswer() {
    isActive = false;
  }

  void tileTapped() {
    if (!isActive) {
      // TODO: add char to answer Chars
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
            )
        )
    );
  }
}