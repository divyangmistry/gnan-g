import 'package:GnanG/UI/level/levelList.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:GnanG/common.dart';

class GameMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GameMainPageState();
  }
}

class GameMainPageState extends State<GameMainPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: BackgroundGredient(
        child: _bodyView(),
      ),
    );
  }

  _bodyView() {
    return new ListView(
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        SizedBox(
          height: 25.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/level_new');
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 4.5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade900,
                    blurRadius: 10.0,
                    spreadRadius: 1.0)
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: Colors.pinkAccent.shade100,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 180,
                  width: 150,
                  child: FlareActor(
                    'assets/animation/Teddy.flr',
                    animation: 'idle',
                  ),
                ),
                Container(
                  child: Text(
                    'GO TO GAME',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/leaderboard');
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 4.5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade900,
                    blurRadius: 10.0,
                    spreadRadius: 1.0)
              ],
              color: Colors.orange.shade300,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 180,
                  width: 150,
                  child: FlareActor(
                    'assets/animation/leaderboard.flr',
                    animation: 'clouds',
                  ),
                ),
                Container(
                  child: Text(
                    'GO TO GAME',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 4.5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue.shade400,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade900,
                    blurRadius: 10.0,
                    spreadRadius: 1.0)
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Container(
              alignment: Alignment(0.5, 0.0),
              child: Text(
                'BONUS',
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/gameOf15');
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 4.5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.green.shade400,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade900,
                    blurRadius: 10.0,
                    spreadRadius: 1.0)
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Container(
              alignment: Alignment(0.5, 0.0),
              child: Text(
                'PUZZLE',
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
