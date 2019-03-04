import 'package:GnanG/UI/game/dashboard.dart';
import 'package:GnanG/UI/intro/intro.dart';
import 'package:GnanG/UI/leaderboard.dart';
import 'package:GnanG/UI/others/feedback.dart';
import 'package:GnanG/UI/profile.dart';
import 'package:GnanG/UI/puzzle/main.dart';

import 'package:GnanG/no-internet-page.dart';
import 'package:GnanG/utils/app_setting_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'UI/auth/forgot_password.dart';
import 'UI/auth/new_login.dart';
import 'UI/auth/new_otp.dart';
import 'UI/auth/new_signup.dart';
import 'UI/auth/register_new.dart';
import 'UI/game/mainGame.dart';
import 'UI/game/simple_game.dart';
import 'UI/level/levelList.dart';
import 'UI/level/level_transition.dart';
import 'UI/others/rules.dart';
import 'UI/others/terms&condition.dart';
import 'UI/profile.dart';
import 'colors.dart';

class QuizApp extends StatefulWidget {
  final Widget defaultHome;

  QuizApp({@required this.defaultHome});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  @override
  void initState() {
    super.initState();
    AppSetting.startBackgroundMusic();
    registerForAppStateChange();
  }

  void registerForAppStateChange() {
    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg == "AppLifecycleState.paused" || msg == "AppLifecycleState.inactive" || msg == "AppLifecycleState.suspending") {
        AppSetting.stopBackgroundMusic();
      } else if (msg == "AppLifecycleState.resumed") {
        AppSetting.startBackgroundMusic();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gnan-G',
      home: widget.defaultHome,
      theme: _kQuizTheme,
      routes: <String, WidgetBuilder>{
        '/noInternet': (BuildContext context) => new NoInternetPage(),
        '/introPage': (BuildContext context) => new IntroPage(),
        '/feedback': (BuildContext context) => new FeedbackPage(),
        '/simpleGame': (BuildContext context) => new SimpleGame(),
        '/dashboardPage': (BuildContext context) => new DashboardPage(),
        '/game_new': (BuildContext context) => new MainGamePage(),
        '/level_new': (BuildContext context) => new NewLevelPage(),
        '/login_new': (BuildContext context) => new LoginPage(),
        '/register_new': (BuildContext context) => new RegisterPage2(),
        '/signup': (BuildContext context) => new SignUpPage(),
        '/forgotPassword': (BuildContext context) => new ForgotPassword(),
        '/otp_new': (BuildContext context) => new OtpVerifyPage(),
        '/rules': (BuildContext context) => new RulesPagePage(),
        '/profile': (BuildContext context) => new ProfilePagePage(),
        '/leaderboard': (BuildContext context) => new LeaderBoard(),
        '/t&c': (BuildContext context) => new TermsAndConditionPage(),
        '/gameOf15': (BuildContext context) => new GameOfFifteen(),
        'level_transition': (BuildContext context) => new LevelTransitionPage(),
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
        prefixStyle: TextStyle(color: kQuizBrown900)),
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
