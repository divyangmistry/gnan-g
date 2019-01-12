import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/Service/apiservice.dart';
import 'package:kon_banega_mokshadhipati/UI/forgot_password.dart';
import 'package:kon_banega_mokshadhipati/UI/level_ui.dart';
import 'package:kon_banega_mokshadhipati/UI/login_ui.dart';
import 'package:kon_banega_mokshadhipati/UI/game_page.dart';
import 'package:kon_banega_mokshadhipati/UI/register_page.dart';
import 'package:kon_banega_mokshadhipati/UI/send_otp_page.dart';
import 'package:kon_banega_mokshadhipati/UI/simple_game.dart';
import 'package:kon_banega_mokshadhipati/model/CacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService appAuth = new ApiService();
bool _theme = false;
bool _result;

void setTheme(value) {
  _theme = value;
  main();
}

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Set default home.
  Widget _defaultHome = new LoginUI();
  _result = prefs.getBool('b_isUserLoggedIn');
  _theme = await appAuth.checkTheme();

  if (_result) {
    var data = {
      'user_mob': json.decode(prefs.getString('user_info'))['user_info']
          ['mobile']
    };
    Response res = await appAuth.getUserState(json.encode(data));
    if (res.statusCode == 200) {
      Map<String, dynamic> userstateStr = json.decode(res.body)['results'];
      print('IN MAIN ::: userstateStr :::');
      print(userstateStr);
      UserState userState = UserState.fromJson(userstateStr);
      CacheData.userState = userState;
      _defaultHome = new LevelUI();
    } else {
      print('ERROR In MAIN :: ');
      print(res.body);
    }
  } else {
    _defaultHome = new LoginUI();
  }

  runApp(
    MaterialApp(
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
    ),
  );
}
