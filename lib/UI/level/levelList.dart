import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/UI/widgets/base_state.dart';
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

class NewLevelPageState extends BaseState<NewLevelPage> {
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
    isLoading = true;
    const timeOut = const Duration(seconds: 2);
    new Timer(timeOut, () {
      setState(() {
        // TODO : Load levels
        isLoading = false;
      });
    });
  }

  Widget pageToDisplay() {
    return new SafeArea(
      child: Column(
        children: <Widget>[
          new SizedBox(height: 20),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/gameStart');
                  },
                  child: Icon(
                    Icons.person_outline,
                    size: 25,
                    color: kQuizSurfaceWhite,
                  ),
                ),
                new Text(
                  'LEVELS',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kQuizSurfaceWhite,
                      letterSpacing: 4),
                ),
                CommonFunction.pointsUI(
                  point: CacheData.userInfo.totalscore.toString(),
                ),
              ],
            ),
          ),
          new SizedBox(height: 20),
          new LevelList(),
        ],
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
