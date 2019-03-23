import 'package:GnanG/model/cacheData.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../common.dart';
import 'levelRow.dart';
// import 'package:flame/flame.dart';

class NewLevelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewLevelPageState();
}

class NewLevelPageState extends State<NewLevelPage> {
  @override
  void initState() {
    super.initState();
    // Flame.audio.play('music/CV-01Trimantra.mp3');
  }

  @override
  void dipose() {
    super.dispose();
    // Flame.audio.clear('music/CV-01Trimantra.mp3');
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
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: kQuizMain400,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                new Text(
                  'LEVELS',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: kQuizMain500,
                      letterSpacing: 4),
                ),
                CommonFunction.pointsUI(
                  context: context,
                  point: CacheData.userState.totalscore.toString(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGredient(
        child: pageToDisplay(),
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
          itemCount: CacheData.userState.quizLevels.length,
          itemBuilder: (_, index) {
            print('CacheData.userState :: ');
            print(CacheData.userState.currentState.level);
            print(index + 1);
            return new LevelCardRow(CacheData.userState.quizLevels[index], CacheData.userState.currentState.level == index + 1 ? false : true);
          },
        ),
      ),
    );
  }
}
