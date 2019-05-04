import 'package:GnanG/UI/game/mainGame.dart';
import 'package:GnanG/UI/puzzle/main.dart';
import 'package:GnanG/UI/widgets/base_state.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/user_state.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../model/quizlevel.dart';

class LevelCardRow extends StatefulWidget {
  final QuizLevel levelDetails;
  final bool lock;

  LevelCardRow(this.levelDetails, this.lock);

  @override
  _LevelCardRowState createState() => _LevelCardRowState();
}

class _LevelCardRowState extends BaseState<LevelCardRow> {
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
    List<CompletedLevel> completedLevels = CacheData.userState.completed;
    for (CompletedLevel completedLevel in completedLevels) {
      if (completedLevel.level == levelIndex) return true;
    }
    return false;
  }

  Widget levelCard() {
    return new Card(
      color: widget.lock ? Colors.grey[200] : kQuizSurfaceWhite,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: widget.lock ? 0 : 5,
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
                    widget.levelDetails.name,
                    style: TextStyle(
                      color: kQuizBrown900,
                    ),
                    textScaleFactor: 1.8,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: widget.lock
                      ? isCompleted(widget.levelDetails.levelIndex)
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
                      widget.levelDetails.levelIndex.toString(),
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
                      widget.levelDetails.totalscores != null
                          ? widget.levelDetails.totalscores.toString()
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
  Widget pageToDisplay() {
    return new Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          print('LEVEL DETAILS :: ');
          print(widget.levelDetails);
          if (isCompleted(widget.levelDetails.levelIndex)) {
            CommonFunction.alertDialog(
                context: context,
                msg: 'Hooray !!  You have already cleared this level',
                type: "success");
          } else {
            if (CacheData.userState.lives > 0) {
              if (!widget.lock) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new MainGamePage(
                          level: widget.levelDetails,
                        ),
                  ),
                );
              } else {
                bool isLevelCompleted = isCompleted(widget.levelDetails.levelIndex);
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
                    doneButtonFn: () async {
                      setState(() {
                        isOverlay = true;
                      });
                      await CommonFunction.getLife(context);
                      setState(() {
                        isOverlay = false;
                      });
                    },
                    showCancelButton: true);
              } else {
                CommonFunction.alertDialog(
                  context: context,
                  msg:
                      'You don\'t have enough lives.\nYou can earn points and get life from puzzeles',
                  barrierDismissible: false,
                  doneButtonText: 'Play puzzle',
                  showCancelButton: true,
                  type: 'info',
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
