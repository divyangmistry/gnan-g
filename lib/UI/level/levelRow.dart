import 'package:GnanG/UI/game/mainGame.dart';
import 'package:GnanG/UI/puzzle/main.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/user_state.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../model/quizlevel.dart';

class LevelCardRow extends StatelessWidget {
  final QuizLevel levelDetails;
  final bool lock;

  LevelCardRow(this.levelDetails, this.lock);

  Widget levelThumbnail() {
    return new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white54,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/bkg.jpg'),
          ),
        ),
      ),
    );
  }

  bool isCompleted(int levelIndex) {
    List<CompletedLevel> completedLevels = CacheData.userState.completed;
    for(CompletedLevel completedLevel in completedLevels) {
      if(completedLevel.level == levelIndex)
        return true;
    }
    return false;
  }

  Widget levelCard() {
    return new Card(
      color: lock ? Colors.grey[200] : kQuizSurfaceWhite,
      margin: const EdgeInsets.only(left: 72.0, right: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: lock ? 0 : 5,
      child: new Container(
        margin: const EdgeInsets.only(top: 18.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text(
                    levelDetails.name,
                    style: TextStyle(
                      color: kQuizBrown900,
                    ),
                    textScaleFactor: 1.8,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: lock ? Icon(Icons.lock) : new Container(),
                )
              ],
            ),
            new SizedBox(height: 10),
            new Text(
              levelDetails.description != null ? levelDetails.description : "",
              style: TextStyle(
                color: kQuizMain50,
              ),
              textScaleFactor: 1.1,
            ),
            new SizedBox(
              height: 2,
            ),
            new Container(
              color: kQuizMain400,
              width: 48.0,
              height: 2.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
            ),
            new SizedBox(
              height: 4,
            ),
            new Row(
              children: <Widget>[
                new Text(
                  'Level : ',
                  style: TextStyle(color: kQuizMain50),
                ),
                new Text(
                  levelDetails.levelIndex.toString(),
                  style: TextStyle(color: kQuizMain400),
                ),
                new SizedBox(width: 25),
                new Text(
                  'Max. Points : ',
                  style: TextStyle(color: kQuizMain50),
                ),
                new Text(
                  levelDetails.totalscores != null
                      ? levelDetails.totalscores.toString()
                      : "",
                  style: TextStyle(color: kQuizMain400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          print('LEVEL DETAILS :: ');
          print(levelDetails);
          if (CacheData.userState.lives > 0) {
            if (!lock) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new MainGamePage(
                        level: levelDetails,
                      ),
                ),
              );
            } else {
              CommonFunction.alertDialog(
                  context: context, msg: isCompleted(levelDetails.levelIndex) ? 'Hooray !!  You have already cleared this level' : 'This level is lock for you');
            }
          } else {
            if (CacheData.userState.totalscore > 100) {
              CommonFunction.alertDialog(
                context: context,
                msg:
                    'You don\'t have enough points.\nYou can earn life from 100 Points',
                barrierDismissible: false,
                doneButtonText: 'Get Life',
                doneButtonFn: () {
                  Navigator.pop(context);
                },
              );
            } else {
              CommonFunction.alertDialog(
                context: context,
                msg:
                    'You don\'t have enough lifes.\nYou can earn points and get life from puzzeles',
                barrierDismissible: false,
                doneButtonText: 'Play puzzle',
                doneButtonFn: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new GameOfFifteen(),
                    ),
                  );
                },
              );
            }
          }
        },
        child: new Stack(
          children: <Widget>[
            levelCard(),
            levelThumbnail(),
          ],
        ),
      ),
    );
  }
}
