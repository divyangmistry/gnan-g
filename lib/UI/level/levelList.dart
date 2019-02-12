import 'package:flutter/material.dart';
import 'package:SheelQuotient/model/cacheData.dart';
import '../../colors.dart';
import 'levelRow.dart';
import '../../common.dart';
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
          itemExtent: 160.0,
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
