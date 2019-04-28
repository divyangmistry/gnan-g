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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Container(
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
            ))
      ],
    );
  }

  bool isCompleted(int levelIndex) {
    // List<CompletedLevel> completedLevels = CacheData.userState.completed;
    // for (CompletedLevel completedLevel in completedLevels) {
    //   if (completedLevel.level == levelIndex) return true;
    // }
    return false;
  }

  Widget levelCard() {
    return new Card(
      color: lock ? Colors.grey[200] : kQuizSurfaceWhite,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: lock ? 0 : 5,
      child: new Container(
        margin: const EdgeInsets.only(top: 18.0, left: 18.0),
//        constraints: new BoxConstraints.expand(),
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
                  child: lock
                      ? isCompleted(levelDetails.levelIndex)
                          ? CircleAvatar(
                              backgroundColor: Colors.green,
//                              color: Color.fromARGB(0, 1, 1, 1),
//                              shape: CircleBorder(side: BorderSide(style: BorderStyle.solid, color: Colors.green)),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(Icons.done, color: Colors.green),
                                radius: 18,
                              ))
                          : Icon(Icons.lock)
                      : new Container(),
                )
              ],
            ),
            new SizedBox(height: 10),
            new SizedBox(
              height: 2,
            ),
            new SizedBox(
              height: 4,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Text(
                      'Level : ',
                      textScaleFactor: 1,
                      style: TextStyle(color: kQuizMain50),
                    ),
                    new Text(
                      levelDetails.levelIndex.toString(),
                      textScaleFactor: 1,
                      style: TextStyle(color: kQuizMain400),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Text(
                      'Max. Points : ',
                      textScaleFactor: 1,
                      style: TextStyle(color: kQuizMain50),
                    ),
                    new Text(
                      levelDetails.totalscores != null
                          ? levelDetails.totalscores.toString()
                          : "",
                      textScaleFactor: 1,
                      style: TextStyle(color: kQuizMain400),
                    )
                  ],
                ),
              ],
            ),
            new SizedBox(
              height: 6,
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
          if (isCompleted(levelDetails.levelIndex)) {
            CommonFunction.alertDialog(
                context: context,
                msg: 'Hooray !!  You have already cleared this level',
                type: "success");
          } else {
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
                bool isLevelCompleted = isCompleted(levelDetails.levelIndex);
                CommonFunction.alertDialog(
                    context: context,
                    msg: 'This level is locked for you',
                    type: isLevelCompleted ? "success" : 'error');
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
                      CommonFunction.getLife(context);
                    },
                    showCancelButton: true);
              } else {
                CommonFunction.alertDialog(
                  context: context,
                  msg:
                      'You don\'t have enough lives.\nYou can earn points and get life from puzzeles',
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
          }
        },
        child: levelCard(),
      ),
    );
  }
}
