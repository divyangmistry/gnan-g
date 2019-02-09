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
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new BackgroundGredient(
            child: SafeArea(
                child: Column(
      children: <Widget>[
        question(),
        answerTiles(),
        optionTilesOne(),
        optionTilesTwo(),
      ],
    ))));
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
        children: <Widget>[
          optionTile('સિ'),
          optionTile('મં'),
          optionTile('ધ'),
          optionTile('ર'),
          optionTile('સ્વા'),
          optionTile('મી'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  Widget optionTilesTwo() {
    return new Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          optionTile('દા'),
          optionTile('દા'),
          optionTile('ભ'),
          optionTile('ગ'),
          optionTile('વા'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  Widget optionTile(String text) {
    return new Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            text,
            textScaleFactor: 3,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
