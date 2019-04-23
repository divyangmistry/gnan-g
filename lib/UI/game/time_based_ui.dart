import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import '../../colors.dart';
import '../../common.dart';

class TimeBasedUI extends StatefulWidget {
  @override
  State createState() => new TimeBasedUIState();
}

class TimeBasedUIState extends State<TimeBasedUI> {
  Timer _timer;
  int _timeInSeconds = 40; // question timer
  double _remaining = 100; // do not edit
  double _step = 0; // do not edit

  void startTimer() {
    _step = 100 / _timeInSeconds;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_timeInSeconds < 1) {
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

  @override
  initState() {
    super.initState();
    startTimer();
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
                  },
                ),
                Text(
                  'Time based UI',
                  textScaleFactor: 1.5,
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
      appBar: PreferredSize(child: _appBar(), preferredSize: Size.fromHeight(170.0)),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '\nAnswer Tiles\n',
                  textScaleFactor: 1.5,
                ),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _getAnswerDataTile('D'),
                _getAnswerDataTile(' '),
                _getAnswerDataTile('D'),
                _getAnswerDataTile(' '),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '\n\nJumble Tiles\n',
                  textScaleFactor: 1.5,
                ),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _getJumbleDataTile('D'),
                _getJumbleDataTile('A'),
                _getJumbleDataTile('D'),
                _getJumbleDataTile('A'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
