import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/question.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../common.dart';

class TimeBasedUI extends StatefulWidget {
  final String title;
  final int questionNumber;
  final int totalQuestion;
  final int timeLimit;
  final Widget gameUI;
  final Function loadNextQuestion;
  final Widget timeIndicator;
  final Function timer;
  final Function timeOverDialog;
  final Question questionInfo;
  final Function markRead;

  TimeBasedUI({
    this.title,
    this.questionNumber,
    this.totalQuestion,
    this.timeLimit = 0,
    this.gameUI,
    this.loadNextQuestion,
    this.timeIndicator,
    this.timer,
    this.timeOverDialog,
    this.questionInfo,
    this.markRead,
  });

  @override
  State createState() => new TimeBasedUIState();
}

class TimeBasedUIState extends State<TimeBasedUI> {

  @override
  initState() {
    super.initState();
    widget.timer();
    widget.markRead();
  }

  @override
  Widget build(BuildContext context) {

    Widget _getAnswerDataTile(String char) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: MaterialButton(
          color: char == ' ' ? Colors.black38 : Colors.white,
          onPressed: char == ' ' ? null : () {},
          minWidth: 55,
          height: 55,
          elevation: char == ' ' ? 0 : 2,
          child: Text(
            char,
            textScaleFactor: 1.5,
            style: TextStyle(color: kQuizMain400),
          ),
        ),
      );
    }

    Widget _getJumbleDataTile(String char) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: MaterialButton(
          color: char == 'D' ? Colors.white70 : Colors.white,
          onPressed: char == 'D' ? null : () {},
          minWidth: 55,
          height: 55,
          elevation: char == 'D' ? 0 : 5,
          child: Text(
            char,
            textScaleFactor: 1.5,
            style: TextStyle(color: kQuizMain400),
          ),
        ),
      );
    }

    Widget _appBar() {
      return new Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    print('back button');
                    Navigator.pop(context);
                  },
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.title.toUpperCase(),
                        textScaleFactor: 1.2,
                        style: TextStyle(color: kQuizMain500),
                      ),
                      widget.questionNumber != null
                          ? Row(
                        children: <Widget>[
                          Text(
                            widget.questionNumber.toString() + " / " +
                                widget.totalQuestion.toString(),
                            textScaleFactor: 1.2,
                            style: TextStyle(color: kQuizMain500),
                          )
                        ],
                      )
                          : Container()
                    ],
                  ),
                ),
                CommonFunction.pointsUI(context: context, point: CacheData.userState.totalscore.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.timeIndicator,
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          child: new BackgroundGredient(
            child: _appBar(),
          ), preferredSize: Size.fromHeight(165.0)),
      body: new BackgroundGredient(
        child: SafeArea(
          child: widget.gameUI,
        ),
      ),
    );
  }
}

//ListView(
//children: <Widget>[
//Row(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Text(
//'\nAnswer Tiles\n',
//textScaleFactor: 1.5,
//),
//],
//),
//Wrap(
//crossAxisAlignment: WrapCrossAlignment.center,
//runAlignment: WrapAlignment.center,
//alignment: WrapAlignment.center,
//children: <Widget>[
//_getAnswerDataTile('D'),
//_getAnswerDataTile(' '),
//_getAnswerDataTile('D'),
//_getAnswerDataTile(' '),
//],
//),
//Row(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Text(
//'\n\nJumble Tiles\n',
//textScaleFactor: 1.5,
//),
//],
//),
//Wrap(
//crossAxisAlignment: WrapCrossAlignment.center,
//runAlignment: WrapAlignment.center,
//alignment: WrapAlignment.center,
//children: <Widget>[
//_getJumbleDataTile('D'),
//_getJumbleDataTile('A'),
//_getJumbleDataTile('D'),
//_getJumbleDataTile('A'),
//],
//),
//],
//)