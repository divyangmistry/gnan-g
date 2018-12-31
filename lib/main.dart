import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/Service/apiservice.dart';
import 'package:kon_banega_mokshadhipati/UI/login_ui.dart';
import 'package:kon_banega_mokshadhipati/UI/game_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ApiService appAuth = new ApiService();
  bool _theme = false;
  void set Theme(value) {
    _theme = value;
    main();
  }

  Widget _defaultHome = new LoginUI();
  void main() async {
    bool _result = await appAuth.checkLoginStatus();
    bool _isIntroDone = await appAuth.checkIsIntoVisited();
    _theme = await appAuth.checkTheme();
    if (_isIntroDone) {
      if (_result) {
        _defaultHome = new GameUI();
      }
    } else {
      _defaultHome = new LoginUI();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kon banega mokshadhipati',
      theme: _theme
          ? ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.cyan,
              fontFamily: 'GoogleSans')
          : ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.orangeAccent,
              fontFamily: 'GoogleSans'),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/gameUI': (BuildContext context) => new GameUI(),
        '/login': (BuildContext context) => new LoginUI(),
      },
    );
  }
}
