import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_state.dart';
import '../../colors.dart';
import 'levelRow.dart';
import '../../model/quizlevel.dart';
import '../../common.dart';
// import 'package:flame/flame.dart';

class NewLevelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewLevelPageState();
}

class NewLevelPageState extends State<NewLevelPage> {
  bool display = true;

  @override
  void initState() {
    super.initState();
    loadData();
    // Flame.audio.play('music/CV-01Trimantra.mp3');
  }

  @override
  void dipose() {
    super.dispose();
    // Flame.audio.clear('music/CV-01Trimantra.mp3');
  }

  Future<Null> loadData() async {
    const timeOut = const Duration(seconds: 2);
    new Timer(timeOut, () {
      setState(() {
        // TODO : Load levels
        display = false;
      });
    });
  }

  Widget _pageToDisplay() {
    if (display) {
      return CustomLoading();
    } else {
      return new SafeArea(
        child: Column(
          children: <Widget>[
            new SizedBox(height: 20),
            new Text(
              'LEVELS',
              textScaleFactor: 1.5,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: kQuizSurfaceWhite,
                  letterSpacing: 4),
            ),
            new SizedBox(height: 20),
            new LevelList(),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kQuizSurfaceWhite,
      body: new BackgroundGredient(
        child: _pageToDisplay(),
      ),
    );
  }
}

class LevelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(
        child: new ListView.builder(
          itemExtent: 160.0,
          itemCount: CacheData.userState.quizLevels.length,
          itemBuilder: (_, index) =>
              new LevelCardRow(CacheData.userState.quizLevels[index]),
        ),
      ),
    );
  }
}
