import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kon_banega_mokshadhipati/Service/apiservice.dart';
import 'package:kon_banega_mokshadhipati/UI/forgot_password.dart';
import 'package:kon_banega_mokshadhipati/UI/level_ui.dart';
import 'package:kon_banega_mokshadhipati/UI/login_ui.dart';
import 'package:kon_banega_mokshadhipati/UI/game_page.dart';
import 'package:kon_banega_mokshadhipati/UI/register_page.dart';
import 'package:kon_banega_mokshadhipati/UI/send_otp_page.dart';
import 'package:kon_banega_mokshadhipati/UI/simple_game.dart';
import 'package:kon_banega_mokshadhipati/UI/verify_otp_page.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_state.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  ApiService appAuth = new ApiService();
  bool _theme = false;
  void set Theme(value) {
    _theme = value;
    main();
  }

  MyApp() {
    main();
  }
  Widget _defaultHome = new LoginUI();
  void main() async {
    bool _isAlreadyLoggedIn = await appAuth.checkLoginStatus();
    _isAlreadyLoggedIn = true;
    bool _isIntroDone = await appAuth.checkIsIntoVisited();
    _theme = await appAuth.checkTheme();
    if (true) {
      if (_isAlreadyLoggedIn) {
        _loadUserState();
      }
    } else {
      _defaultHome = new LoginUI();
    }
  }

  _loadUserState() {
    appAuth.getUserState(null).then((res) {
      if (res.statusCode == 200) {
        Map<String,dynamic> userstateStr = json.decode(res.body)['results'];
        print('userstateStr :::');
        print(userstateStr);
        UserState userState = UserState.fromJson(userstateStr);
        CacheData.userState = userState;
        _defaultHome = new SimpleGame();
      }
    });

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
        '/gamePage': (BuildContext context) => new GamePage(),
        '/simpleGame': (BuildContext context) => new SimpleGame(),
        '/login': (BuildContext context) => new LoginUI(),
        '/registerPage': (BuildContext context) => new RegisterPage(),
        '/forgotPassword': (BuildContext context) => new ForgotPassword(),
        '/sendOtp': (BuildContext context) => new SendOTP(),
        '/level': (BuildContext context) => new LevelUI(),
      },
    );
  }
}
