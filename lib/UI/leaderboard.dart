import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LeaderBoard extends StatefulWidget {
  @override
  LeaderBoardState createState() => new LeaderBoardState();
}

class LeaderBoardState extends State<LeaderBoard> {
  
  Container _buildLeaderRow(int rank, String name, int points, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Text(
            rank.toString(),
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
            ),
          ),
          Container(
              child: Icon(
                icon,
                size: 50,
              ),
              padding: EdgeInsets.fromLTRB(18,0,12,0)
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 18
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
            child: Text(
              points.toString(),
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    Widget leaderSection = Column(
      children: <Widget>[
        _buildLeaderRow(1, "Albert Einstein", 160, Icons.face),
        Divider(),
        _buildLeaderRow(2, "Nikola Tesla", 83, Icons.face),
        Divider(),
        _buildLeaderRow(3, "MBA", 56, Icons.face),
      ],
    );

    debugPaintSizeEnabled=false;
    return new Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          leaderSection
        ],
      ),
//      ),
    );
  }
}
