import 'package:GnanG/UI/game_level.dart';
import 'package:GnanG/UI/level/levelList.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/UI/animation/success.dart';
import 'package:flutter/material.dart';
import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/model/cacheData.dart';
import '../../common.dart';
import 'package:nima/nima_actor.dart';

class GameMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GameMainPageState();
  }
}

class GameMainPageState extends State<GameMainPage> {
  ApiService _api = new ApiService();
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
        _gameBar(),
        SizedBox(
          height: 20.0,
        ),
        Center(
            child: Center(
          child: Image.asset(
            'images/logo1.png',
            height: 70.0,
          ),
        )),
        SizedBox(
          height: 20.0,
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
                    blurRadius: 5.0,
                    spreadRadius: 0.5)
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
                  child: new NimaActor("assets/bonus",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "Idle"),
                ),
                Container(
                  child: Text(
                    'Bonus',
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
            Navigator.pushNamed(context, '/gameStart');
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 180,
                    width: 150,
                    child: FlareActor(
                      'assets/animation/person_floating.flr',
                      animation: 'Relaxing',
                    ),
                  ),
                  Container(
                    alignment: Alignment(0.5, 0.0),
                    child: Text(
                      'PROFILE',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget _gameBar() {
    return new Row(
      children: <Widget>[
        _iconButton(
          Icon(Icons.power_settings_new, color: Colors.white),
          () {
            _api.logout();
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/login_new');
          },
        ),
        new Expanded(
          child: Center(
              // child: Text(
              //   'Gnan-G',
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 50.0,
              //       fontWeight: FontWeight.w600),
              // ),
              ),
        ),
        _iconButton(
          Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new SucessAnimationPage(),
              ),
            );
            // Navigator.pushNamed(context, '/rules');
          },
        ),
      ],
    );
  }

  Widget _iconButton(Icon icon, Function clickEvent) {
    return new RaisedButton(
      onPressed: clickEvent,
      child: icon,
      shape: new CircleBorder(),
      elevation: 5.0,
      padding: const EdgeInsets.all(10.0),
    );
  }
}
