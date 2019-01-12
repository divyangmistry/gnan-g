import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/current_stat.dart';
import 'package:kon_banega_mokshadhipati/model/quizlevel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/apiservice.dart';

class LevelUI extends StatefulWidget {
  static final String MODULE = "[LevelUI] ";

  @override
  LevelUIState createState() {
    return new LevelUIState();
  }
}

class LevelUIState extends State<LevelUI> {
  List<QuizLevel> levelinfos = [];
  ApiService _api = new ApiService();
  Map<dynamic, dynamic> _userData;

  

  @override
  void initState() {
    // TODO: implement initState
    _getLevels();
    super.initState();
  }

  _getLevels() {
    levelinfos = CacheData.userState.quizLevels;
    // SharedPreferences.getInstance().then((localstorage) {
    //   _userData = json.decode(localstorage.getString('user_info'));
    //   print('USER DATA : ');
    //   print(_userData);
    //   var data;
    //   data = {"user_mob": _userData['user_info']['mobile']};
    //   _api.getLevels(json.encode(data)).then((res) {
    //     if (res.statusCode == 200) {
    //       print('LEVELS : ');
    //       print(res.body);
    //     } else {}
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBarView(),
      body: _bodyView(),
    );
  }

  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text(
        'Level',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.w300,
        ),
      ),
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

  Widget getLevelButton(QuizLevel levelInfo) {
    return new Padding(
      padding: EdgeInsets.all(10.0),
      child: new OutlineButton(
        onPressed: () {Navigator.pushReplacementNamed(context, '/simpleGame');},
        child: Text(
          levelInfo.name,
          textScaleFactor: 1.5,
        ),
        shape: new CircleBorder(),
        borderSide: BorderSide(color: Colors.blue),
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
