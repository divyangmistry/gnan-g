import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/current_stat.dart';
import 'package:kon_banega_mokshadhipati/UI/simple_game.dart';
import 'package:kon_banega_mokshadhipati/model/quizlevel.dart';
import '../Service/apiservice.dart';

class LevelUI extends StatefulWidget {
  static final String module = "[LevelUI] ";

  @override
  LevelUIState createState() {
    return new LevelUIState();
  }
}

class LevelUIState extends State<LevelUI> {
  List<QuizLevel> levelinfos = [];
  ApiService _api = new ApiService();

  @override
  void initState() {
    _getLevels();
    super.initState();
  }

  _getLevels() {
    levelinfos = CacheData.userState.quizLevels;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBarView(),
      body: _bodyView(),
    );
  }

  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text(
        'Level',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  _bodyView() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              levelinfos.map((levelInfo) => getLevelButton(levelInfo)).toList(),
        ),
      ),
    );
  }

  Widget getLevelButton(QuizLevel levelInfo) {
    return new Padding(
      padding: EdgeInsets.all(10.0),
      child: new OutlineButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SimpleGame(
                    level: levelInfo.levelIndex,
                  ),
            ),
          );
        },
        child: Text(
          levelInfo.levelIndex.toString(),
          textScaleFactor: 1.5,
        ),
        shape: new CircleBorder(),
        borderSide: BorderSide(color: Colors.blue),
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
