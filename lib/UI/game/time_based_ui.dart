import 'dart:async';

import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/model/question.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import '../../colors.dart';
import '../../common.dart';

class TimeBasedUI extends StatefulWidget {
  final String title;
  final int questionNumber;
  final int totalQuestion;
  final int timeLimit;
  final Widget gameUI;
  final Function loadNextQuestion;
  final Question questionInfo;
  ValueListenable<bool> isReset;
  final Function markRead;

  TimeBasedUI({this.title, this.questionNumber, this.totalQuestion, this.timeLimit = 0, this.gameUI, this.loadNextQuestion, this.questionInfo, this.isReset, this.markRead});

  @override
  State createState() => new TimeBasedUIState();
}

class TimeBasedUIState extends State<TimeBasedUI> {

  ApiService _api = new ApiService();

  Timer _timer;
  int _timeInSeconds = 500; // question timer
  double _remaining = 100; // do not edit
  double _step = 0; // do not edit

  void startTimer() {
    _timeInSeconds = widget.timeLimit;
    _step = 100 / _timeInSeconds;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_timeInSeconds < 1) {
                timeOverDialog();
                timer.cancel();
              } else {
                _remaining = _remaining - _step;
                _chartKey.currentState.updateData(
                  <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                            _timeInSeconds == 1 ? 0 : _remaining, kQuizMain400,
                            rankKey: 'completed'),
                        new CircularSegmentEntry(
                            100, kQuizMain400.withAlpha(50),
                            rankKey: 'remaining'),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                );
                _timeInSeconds = _timeInSeconds - 1;
              }
            },
          ),
    );
  }

  void timeOverDialog() {
    _timer.cancel();
    CommonFunction.alertDialog(
      context: context,
      msg: 'Time\'s up !!',
      type: 'info',
      showCancelButton: true,
      barrierDismissible: false,
      cancelButtonText: 'Exit Level',
      doneCancelFn: _goToLevel,
      doneButtonText: 'Next Question',
      doneButtonFn: _loadNextQuestion,
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  void resetTimer() {
    stopTimer();
    _remaining = 100;
    startTimer();
  }

  _loadNextQuestion()  {
    widget.loadNextQuestion();
    widget.questionInfo.questionSt += 1;
    resetTimer();
    widget.markRead();
  }

  void _goToLevel() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

//  _markReadQuestion() async {
//    Response res = await _api.markReadQuestion(
//      level: widget.questionInfo.level,
//      mhtId: CacheData.userInfo.mhtId,
//      questionId: widget.questionInfo.questionId,
//      questionSt: widget.questionInfo.questionSt
//    );
//    AppResponse appResponse =
//    ResponseParser.parseResponse(context: context, res: res);
//    if (appResponse.status == WSConstant.SUCCESS_CODE) {
//      print('ReadQuestion :: ');
//      print(appResponse.data);
//      CacheData.userState.currentState.questionReadSt = appResponse.data['question_read_st'];
//    }
//  }

  @override
  initState() {
    widget.isReset.addListener(() {
    if (widget.isReset.value) {
      resetTimer();
//      widget.isReset.value = false;
    }
  });

    super.initState();
    startTimer();
    widget.markRead();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {

    print('VALUE CHANGED .. :::: ');
    print(widget.isReset.value);
//    if (widget.isReset.value == true) {
//      print('VALUE CHANGED .. ');
//      resetTimer();
//    }

    Widget _timeIndicator() {
      return new AnimatedCircularChart(
        key: _chartKey,
        size: const Size(100.0, 100.0),
        edgeStyle: SegmentEdgeStyle.round,
        holeRadius: 25,
        initialChartData: <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry(
                0,
                kQuizMain400,
                rankKey: 'completed',
              ),
              new CircularSegmentEntry(
                100,
                kQuizMain400.withAlpha(50),
                rankKey: 'remaining',
              ),
            ],
            rankKey: 'progress',
          ),
        ],
        chartType: CircularChartType.Radial,
        percentageValues: true,
        holeLabel: "$_timeInSeconds",
        labelStyle: new TextStyle(
          color: Colors.blueGrey[600],
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      );
    }

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
                            widget.questionNumber.toString() + " / " + widget.totalQuestion.toString(),
                            textScaleFactor: 1.2,
                            style: TextStyle(color: kQuizMain500),
                          )
                        ],
                      )
                          : Container()
                    ],
                  ),
                ),
                CommonFunction.pointsUI(context: context, point: '120'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _timeIndicator(),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: PreferredSize(child: _appBar(), preferredSize: Size.fromHeight(190.0)),
      body: SafeArea(
        child: widget.gameUI,
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