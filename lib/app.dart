import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Service/apiservice.dart';
import 'UI/game/mainGame.dart';
import 'UI/level/levelList.dart';
import 'UI/auth/register_new.dart';
import 'UI/auth/new_otp.dart';
import 'UI/auth/new_signup.dart';
import 'UI/auth/forgot_password.dart';
import 'UI/game_level.dart';
import 'UI/game/game_page.dart';
import 'UI/game/leaderboar.dart';
import 'UI/auth/new_login.dart';
import 'UI/profile.dart';
import 'UI/others/rules.dart';
import 'UI/game/simple_game.dart';
import 'UI/others/terms&condition.dart';
import 'model/cacheData.dart';
import 'model/user_state.dart';

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
        _defaultHome = new NewLevelPage();
      } else {
        _defaultHome = new LoginPage();
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
        '/game_new': (BuildContext context) => new MainGamePage(),
        '/level_new': (BuildContext context) => new NewLevelPage(),
        '/login_new': (BuildContext context) => new LoginPage(),
        '/register_new': (BuildContext context) => new RegisterPage2(),
        '/signup': (BuildContext context) => new SignUpPage(),
        '/forgotPassword': (BuildContext context) => new ForgotPassword(),
        '/otp_new': (BuildContext context) => new OtpVerifyPage(),
        '/gameStart': (BuildContext context) => new GameLevelPage(),
        '/rules': (BuildContext context) => new RulesPagePage(),
        '/profile': (BuildContext context) => new ProfilePagePage(),
        '/leaderboard': (BuildContext context) => new LeaderboarPagePage(),
        '/t&c': (BuildContext context) => new TermsAndConditionPage(),
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
    primaryColor: kQuizMain100,
    scaffoldBackgroundColor: kQuizBackgroundWhite,
    cardColor: kQuizBackgroundWhite,
    textSelectionColor: kQuizMain100,
    errorColor: kQuizErrorRed,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kQuizMain400,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: kQuizBrown900),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      prefixStyle: TextStyle(color: kQuizBrown900)
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
        fontFamily: 'CmSans',
        displayColor: kQuizBrown900,
        bodyColor: kQuizBrown900,
      );
}
