import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:flutter/material.dart';

class GameTitleBar extends StatelessWidget {
  final String title;
  final int questionNumber;

  GameTitleBar({this.title, this.questionNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: kQuizSurfaceWhite,
              ),
              onPressed: () {
                // Flame.audio.clear('music/bensound-epic.mp3');
                // Flame.audio.clearCache();
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  title.toUpperCase(),
                  textScaleFactor: 1.2,
                  style: TextStyle(color: kQuizSurfaceWhite),
                ),
                questionNumber != null
                    ? Row(
                        children: <Widget>[
                          Text(
                            "Question: ",
                            textScaleFactor: 0.9,
                            style: TextStyle(color: kQuizSurfaceWhite),
                          ),
                          Text(
                            questionNumber.toString(),
                            textScaleFactor: 1.2,
                            style: TextStyle(color: kQuizSurfaceWhite),
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
          Container(
            child: CommonFunction.pointsUI(
              context: context,
              point: CacheData.userState.totalscore.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
