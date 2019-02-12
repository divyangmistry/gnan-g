import 'package:flutter/material.dart';
import 'package:SheelQuotient/UI/game/mainGame.dart';
import 'package:SheelQuotient/UI/puzzle/main.dart';
import 'package:SheelQuotient/common.dart';
import 'package:SheelQuotient/model/cacheData.dart';
import '../../colors.dart';
import '../../model/quizlevel.dart';

class LevelCardRow extends StatelessWidget {
  final QuizLevel levelDetails;

  LevelCardRow(this.levelDetails);

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

  Widget levelCard() {
    return new Card(
      color: kQuizSurfaceWhite,
      margin: const EdgeInsets.only(left: 72.0, right: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      child: new Container(
        margin: const EdgeInsets.only(top: 18.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              levelDetails.name,
              style: TextStyle(
                color: kQuizBrown900,
              ),
              textScaleFactor: 1.8,
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
                  'Point : ',
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new MainGamePage(
                      level: levelDetails,
                    ),
              ),
            );
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
