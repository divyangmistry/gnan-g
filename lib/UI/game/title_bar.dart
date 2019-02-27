import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:flutter/material.dart';

class GameTitleBar extends StatelessWidget {
  final String title;

  GameTitleBar(this.title);

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
            child: Text(
              title.toUpperCase(),
              textScaleFactor: 1.2,
              style: TextStyle(color: kQuizSurfaceWhite),
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
