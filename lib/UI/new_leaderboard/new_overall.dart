import 'package:GnanG/UI/new_leaderboard/new_leaderboard.dart';
import 'package:GnanG/model/leaders.dart';
import 'package:flutter/material.dart';

class NewOverAllLeaderBoard extends StatefulWidget {
  final List<Leaders> leaderList;

  NewOverAllLeaderBoard(this.leaderList);

  @override
  _NewOverAllLeaderBoardState createState() => _NewOverAllLeaderBoardState();
}

class _NewOverAllLeaderBoardState extends State<NewOverAllLeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.leaderList != null
            ? ListView.builder(
                itemCount: widget.leaderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return LeaderRow(
                    index + 1,
                    widget.leaderList[index].name,
                    widget.leaderList[index].totalscore,
                    Icons.face,
                    widget.leaderList[index].mhtId,
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
