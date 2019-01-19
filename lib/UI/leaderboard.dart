import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LeaderBoard extends StatefulWidget {
  @override
  LeaderBoardState createState() => new LeaderBoardState();
}

class LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Text(
            '1',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          Icon(
            Icons.face,
          ),
          Expanded(
            child: Text('Albert Einstein'),
          ),
          Text(
            '160',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );

    debugPaintSizeEnabled=true;
    return new Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: Colors.blue,
      ),
      body: new SafeArea(
//        child: new Center(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("2nd"),
              Image.asset("images/face.png"),
              Text("83pts"),
            ],
          ),
        ),
//      ),
    );
  }
}
