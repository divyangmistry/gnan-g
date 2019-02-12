import 'package:flutter/material.dart';
import 'package:SheelQuotient/Service/apiservice.dart';
import 'package:SheelQuotient/model/cacheData.dart';
import '../common.dart';
import '../colors.dart';

class GameLevelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameLevelPageState();
}

class GameLevelPageState extends State<GameLevelPage> {
  ApiService _api = new ApiService();
  bool _isloading = true;

  GameLevelPageState() {
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kQuizSurfaceWhite,
      body: BackgroundGredient(
        child: new SafeArea(
          child: CustomLoading(
            isLoading: _isloading,
            child: new ListView(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              children: <Widget>[
                _gameBar(),
                SizedBox(
                  height: 20.0,
                ),
                _userCard(),
                SizedBox(
                  height: 20.0,
                ),
                _bonusRoundInfo(),
                SizedBox(
                  height: 20.0,
                ),
                _bottomButtons(),
              ],
            ),
          ),
        ),
      ),
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
            child: Image.asset(
              'images/logo1.png',
              height: 70.0,
            ),
          ),
        ),
        _iconButton(
          Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          () {
            Navigator.pushNamed(context, '/rules');
          },
        ),
      ],
    );
  }

  Widget _userCard() {
    return new Container(
      height: 250,
      child: new Stack(
        children: <Widget>[
          _userDetail(),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: _userAvatar(),
          ),
        ],
      ),
    );
  }

  Widget _bonusRoundInfo() {
    return Card(
      elevation: 5.0,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Next Game',
              textScaleFactor: 1.5,
              style: TextStyle(color: kQuizMain400),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                _bonusData(Icons.access_time, 'Tommorrow', '07:00 pm'),
                CustomVerticalDivider(height: 80.0),
                _bonusData(Icons.monetization_on, 'Points', '\$200'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _button(
          'Leaderboard',
          Icons.poll,
          () {
            Navigator.pushNamed(context, '/leaderboard');
          },
        ),
        SizedBox(width: 10.0),
        _button(
          'Play Puzzle',
          Icons.play_circle_filled,
          () {
            Navigator.pushNamed(context, '/gameOf15');
          },
        ),
      ],
    );
  }

  Widget _button(String btnLable, icon, Function clickEvent) {
    return Expanded(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 10.0,
        padding: EdgeInsets.all(12.0),
        onPressed: clickEvent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: kQuizSurfaceWhite),
            SizedBox(width: 10),
            Text(
              btnLable,
              style: TextStyle(
                color: kQuizSurfaceWhite,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bonusData(icon, String title, String value) {
    return Expanded(
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {
              print(' ----> SHOW USER DATA ! <----');

              CommonFunction.alertDialog(
                  context: context, msg: CacheData.userState.toString());
            },
            // size: 40.0,
            color: kQuizBrown900,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: kQuizMain50,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            value,
            textScaleFactor: 1.5,
            style: TextStyle(color: kQuizMain400),
          ),
        ],
      ),
    );
  }

  Widget _userDetail() {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.grey[50],
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 50,
            ),
            new Text(
              CacheData.userInfo.name,
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                color: kQuizMain400,
              ),
            ),
            new SizedBox(
              height: 30,
            ),
            new Row(
              children: <Widget>[
                _scoreData(
                    'Points', '\$' + CacheData.userState.totalscore.toString()),
                CustomVerticalDivider(height: 60),
                _scoreData('Rank', '4th'),
                CustomVerticalDivider(height: 60),
                _scoreData('Lives', CacheData.userState.lives.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreData(String title, String value) {
    return new Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: kQuizMain50),
            ),
            SizedBox(height: 5.0),
            Text(
              value,
              textScaleFactor: 2,
              style: TextStyle(color: kQuizMain400),
            )
          ],
        ),
      ),
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

  Widget _userAvatar() {
    return CircleAvatar(
      maxRadius: 50,
      child: CircleAvatar(
        maxRadius: 45,
        backgroundImage: AssetImage('images/face.jpg'),
      ),
      backgroundColor: kQuizBrown900,
    );
  }
}
