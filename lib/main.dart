import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GnanG/UI/splash_screen/splash_screen.dart';
import 'package:GnanG/app.dart';

Widget _defaultHome = new SplashScreen();

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(QuizApp(defaultHome: _defaultHome));
  });
}
