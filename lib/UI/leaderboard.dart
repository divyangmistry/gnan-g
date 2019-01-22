import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LeaderBoard extends StatefulWidget {
  @override
  LeaderBoardState createState() => new LeaderBoardState();
}

class LeaderBoardState extends State<LeaderBoard> {
  
  Container _buildLeaderRow(int rank, String name, int points, IconData icon, String imagePath) {
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
            padding: EdgeInsets.fromLTRB(18,0,12,0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(imagePath)
                  )
              )
            ),
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

  Container _buildUserRow(int rank, int points, String picPath) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 33,
            child:
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    rank.toString(),
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white
                    ),
                  ),
                  Text('nd',
                    style: TextStyle(
                        color: Colors.white
                    ),)
                ],
              ),
            ),
          ),
//          Expanded(
//            flex: 33,
//            child:
            Container(
//                padding: EdgeInsets.symmetric(horizontal: 36),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/face.jpg')
                )
              ),
            ),
//          ),
          Expanded(
            flex: 33,
            child:
            Container(
//              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    points.toString(),
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white),
                  ),
                  Text('pts',
                    style: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                        color: Colors.white
                    ),)
                ],
              ),
            )
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    Widget topSection = Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white
              ),
            ),
          ),
          _buildUserRow(1, 83456, 'image/face.jpg')
        ],
      )
    );

    Widget leaderSection = Column(
      children: <Widget>[
        _buildLeaderRow(1, "If we have a very long name", 83456, Icons.face, 'images/face.jpg'),
        Divider(),
        _buildLeaderRow(2, "Nikola Tesla", 83, Icons.face, 'images/rank2.jpg'),
        Divider(),
        _buildLeaderRow(3, "MBA", 56, Icons.face, 'images/rank3.jpg'),
      ],
    );

    debugPaintSizeEnabled=false;
    return new Scaffold(
      appBar: AppBar(
        title: Text(""),
        bottom: PreferredSize(child: topSection, preferredSize: Size(100, 100)),
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
