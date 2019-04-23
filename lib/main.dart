import 'package:GnanG/UI/game/time_based_ui.dart';
import 'package:GnanG/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Widget _defaultHome = new SplashScreen();
Widget _defaultHome = new TimeBasedUI();
//Widget _defaultHome = new BottomNavigationDemo();

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(QuizApp(defaultHome: _defaultHome));
  });
}
