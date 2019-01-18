import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/Service/apiservice.dart';
import 'package:kon_banega_mokshadhipati/UI/forgot_password.dart';
import 'package:kon_banega_mokshadhipati/UI/game_level.dart';
import 'package:kon_banega_mokshadhipati/UI/game_page.dart';
import 'package:kon_banega_mokshadhipati/UI/leaderboar.dart';
import 'package:kon_banega_mokshadhipati/UI/level_ui.dart';
import 'package:kon_banega_mokshadhipati/UI/login_ui.dart';
import 'package:kon_banega_mokshadhipati/UI/new_login.dart';
import 'package:kon_banega_mokshadhipati/UI/profile.dart';
import 'package:kon_banega_mokshadhipati/UI/register_page.dart';
import 'package:kon_banega_mokshadhipati/UI/rules.dart';
import 'package:kon_banega_mokshadhipati/UI/send_otp_page.dart';
import 'package:kon_banega_mokshadhipati/UI/simple_game.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  Widget _defaultHome = new LoginPage();
  ApiService _api = new ApiService();

  @override
  void initState() {
    // _checkLoginStatus();
    super.initState();
  }

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isLogin = prefs.getBool('b_isUserLoggedIn') == null
        ? false
        : prefs.getBool('b_isUserLoggedIn');

    if (_isLogin) {
      _getInitData(_isLogin,
          json.decode(prefs.getString('user_info'))['user_info']['mobile']);
    }
  }

  _getInitData(_result, mobile) async {
    if (_result) {
      _defaultHome = new GameLevelPage();
      var data = {'user_mob': mobile};
      Response res = await _api.getUserState(json.encode(data));
      if (res.statusCode == 200) {
        Map<String, dynamic> userstateStr = json.decode(res.body)['results'];
        print('IN MAIN ::: userstateStr :::');
        print(userstateStr);
        UserState userState = UserState.fromJson(userstateStr);
        CacheData.userState = userState;
        _defaultHome = new LevelUI();
      } else {
        _defaultHome = new LoginUI();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      home: _defaultHome,
      theme: _kQuizTheme,
      routes: <String, WidgetBuilder>{
        '/gamePage': (BuildContext context) => new GamePage(),
        '/simpleGame': (BuildContext context) => new SimpleGame(),
        '/login': (BuildContext context) => new LoginUI(),
        '/registerPage': (BuildContext context) => new RegisterPage(),
        '/forgotPassword': (BuildContext context) => new ForgotPassword(),
        '/sendOtp': (BuildContext context) => new SendOTP(),
        '/level': (BuildContext context) => new LevelUI(),
        '/gameStart': (BuildContext context) => new GameLevelPage(),
        '/rules': (BuildContext context) => new RulesPagePage(),
        '/profile': (BuildContext context) => new ProfilePagePage(),
        '/leaderboard': (BuildContext context) => new LeaderboarPagePage(),
      },
    );
  }
}

final ThemeData _kQuizTheme = _buildQuizTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kQuizBrown900);
}

ThemeData _buildQuizTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kQuizBrown900,
    primaryColor: kQuizPink100,
    scaffoldBackgroundColor: kQuizBackgroundWhite,
    cardColor: kQuizBackgroundWhite,
    textSelectionColor: kQuizPink100,
    errorColor: kQuizErrorRed,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kQuizPink100,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: kQuizBrown900),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    textTheme: _buildQuizTextTheme(base.textTheme),
    primaryTextTheme: _buildQuizTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildQuizTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildQuizTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'GoogleSans',
        displayColor: kQuizBrown900,
        bodyColor: kQuizBrown900,
      );
}
