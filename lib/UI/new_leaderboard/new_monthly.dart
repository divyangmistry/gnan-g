import 'package:GnanG/UI/new_leaderboard/new_leaderboard.dart';
import 'package:GnanG/model/leaders.dart';
import 'package:flutter/material.dart';

class NewMonthlyLeaderBoard extends StatefulWidget {
  final List<Leaders> leaderList;

  NewMonthlyLeaderBoard(this.leaderList);

  @override
  _NewMonthlyLeaderBoardState createState() => _NewMonthlyLeaderBoardState();
}

class _NewMonthlyLeaderBoardState extends State<NewMonthlyLeaderBoard> {
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
              widget.leaderList[index].totalscoreMonth,
              Icons.face,
              widget.leaderList[index].mhtId,
              widget.leaderList[index].profilePic
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
