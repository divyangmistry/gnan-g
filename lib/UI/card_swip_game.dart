import 'package:flutter/material.dart';

class CardSwipGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CardSwipGameState();
  }
}

class CardSwipGameState extends State<CardSwipGame> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: _appbarView(),
      body: _bodyView(),
      bottomNavigationBar: _bottomBarView(),
    );
  }

  _appbarView() {
    return new AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  _bodyView() {
    return new Center();
  }

  _bottomBarView() {
    return new BottomAppBar(
      elevation: 0.0,
      color: Colors.transparent,
      child: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new Row(
          children: <Widget>[],
        ),
      ),
    );
  }
}

class RoundIconButtons extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  RoundIconButtons.large({this.icon, this.iconColor, this.onPressed})
      : size = 60.0;

  RoundIconButtons.small({this.icon, this.iconColor, this.onPressed})
      : size = 50.0;

  RoundIconButtons({this.icon, this.iconColor, this.size, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black87, blurRadius: 10.0)]),
      child: RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
