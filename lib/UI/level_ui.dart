import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/model/levelinfo.dart';

class LevelUI extends StatefulWidget {
  static final String MODULE = "[LevelUI] ";

  @override
  LevelUIState createState() {
    return new LevelUIState();
  }
}

class LevelUIState extends State<LevelUI> {
  final List<LevelInfo> levelinfos = [];

  @override
  Widget build(BuildContext context) {
    levelinfos.clear();
    levelinfos.add(LevelInfo(1, "1"));
    levelinfos.add(LevelInfo(2, "2"));
    return new Scaffold(
      appBar: _appBarView(),
      body: _bodyView(),
    );
  }

  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text('Level',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w300)),
    );
  }

  _bodyView() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              levelinfos.map((levelInfo) => getLevelButton(levelInfo)).toList(),
        ),
      ),
    );
  }

  Widget getLevelButton(LevelInfo levelInfo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new MaterialButton(
        onPressed: null,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        color: Theme.of(context).primaryColor,
        child: new Text(
          levelInfo.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
