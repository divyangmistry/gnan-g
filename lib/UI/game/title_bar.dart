import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:flutter/material.dart';

class GameTitleBar extends StatelessWidget {
  final String title;
  final int questionNumber;
  final int totalQuestion;

  GameTitleBar({this.title, this.questionNumber, this.totalQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: kQuizMain400,
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
                  style: TextStyle(color: kQuizMain500),
                ),
                questionNumber != null
                    ? Row(
                        children: <Widget>[
                          Text(
                            questionNumber.toString() + " / " + totalQuestion.toString(),
                            textScaleFactor: 1.2,
                            style: TextStyle(color: kQuizMain500),
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
              point: CacheData.userState.totalscore_month.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
