import 'package:flutter/material.dart';

class GameLevelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GameLevelPageState();
}

class GameLevelPageState extends State<GameLevelPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bkg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new SafeArea(
          child: new ListView(
            padding: EdgeInsets.all(15.0),
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
    );
  }

  Widget _gameBar() {
    return new Row(
      children: <Widget>[
        _iconButton(
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        new Expanded(
          child: Center(
            child: Image.asset(
              'images/logo.png',
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
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: _userAvatar(),
          ),
        ],
      ),
    );
  }

  Widget _bonusRoundInfo() {
    return Card(
      elevation: 10.0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Next Game',
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.pink),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                _bonusData(Icons.access_time, 'Tommorrow', '07:00 pm'),
                VerticalDivider(
                  height: 80.0,
                ),
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
        _button('Leaderboard', Icons.poll, () {
          Navigator.pushNamed(context, '/leaderboard');
        }),
        SizedBox(width: 10.0),
        _button('Invites', Icons.donut_large, () {}),
      ],
    );
  }

  Widget _button(String btnLable, icon, Function clickEvent) {
    return Expanded(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        color: Colors.purple[100],
        elevation: 10.0,
        padding: EdgeInsets.all(12.0),
        onPressed: clickEvent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Icon(icon), SizedBox(width: 10), Text(btnLable)],
        ),
      ),
    );
  }

  Widget _bonusData(icon, String title, String value) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 40.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Title(
            child: Text(title),
            color: Colors.grey,
          ),
          SizedBox(height: 5.0),
          Text(
            value,
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.pink),
          ),
        ],
      ),
    );
  }

  Widget _userDetail() {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 50,
            ),
            new Text(
              'Milan Vadher',
              textScaleFactor: 1.5,
              style: TextStyle(
                color: Colors.pink,
              ),
            ),
            new SizedBox(
              height: 30,
            ),
            new Row(
              children: <Widget>[
                _scoreData('Points', '\$10'),
                VerticalDivider(height: 60),
                _scoreData('Rank', '15th'),
                VerticalDivider(height: 60),
                _scoreData('Lives', '05'),
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
            Title(
              child: Text(title),
              color: Colors.grey,
            ),
            SizedBox(height: 5.0),
            Text(
              value,
              textScaleFactor: 2,
              style: TextStyle(color: Colors.pink),
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
      color: Colors.purple[500],
      shape: new CircleBorder(),
      elevation: 5.0,
      padding: const EdgeInsets.all(10.0),
    );
  }

  Widget _userAvatar() {
    return new Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white54,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://avatars2.githubusercontent.com/u/16611246?s=400&v=4'),
        ),
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  final double height;
  VerticalDivider({this.height: 40});
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height,
      width: 1.0,
      color: Colors.grey,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}
