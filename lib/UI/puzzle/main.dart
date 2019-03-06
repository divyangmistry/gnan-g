import 'dart:io';

import 'package:GnanG/UI/puzzle/play_games.dart';
import 'package:GnanG/UI/puzzle/widgets/game/page.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/utils/app_utils.dart';
import 'package:GnanG/utils/audio_utilsdart.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameOfFifteen extends StatefulWidget {



  @override
  GameOfFifteenState createState() {
    return new GameOfFifteenState();
  }
}

class GameOfFifteenState extends State<GameOfFifteen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PlayGamesContainer(
      child: BackgroundGredient(
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Gnan-G';
    if (Platform.isIOS) {
      return _MyCupertinoApp(title: title);
    } else {
      // Every other OS is based on a material
      // design application.
      return _MyMaterialApp(title: title);
    }
  }
}

/// Base class for all platforms, such as
/// [Platform.isIOS] or [Platform.isAndroid].
abstract class _MyPlatformApp extends StatelessWidget {
  final String title;

  _MyPlatformApp({@required this.title});
}

class _MyMaterialApp extends _MyPlatformApp {
  _MyMaterialApp({@required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    // final ui = ConfigUiContainer.of(context);

    // // Get current theme from
    // // a global state.
    // final overlay = ui.useDarkTheme
    //     ? SystemUiOverlayStyle.light
    //     : SystemUiOverlayStyle.dark;
    // final theme = ui.useDarkTheme ? ThemeData.dark() : ThemeData.light();

    // SystemChrome.setSystemUIOverlayStyle(
    //   overlay.copyWith(
    //     statusBarColor: Colors.transparent,
    //   ),
    // );

    return BackgroundGredient(
      child: MaterialApp(
        title: title,
        // theme: theme.copyWith(
        //   primaryColor: Colors.blue,
        //   accentColor: Colors.amberAccent,
        //   accentIconTheme: theme.iconTheme.copyWith(color: Colors.black),
        //   dialogTheme: const DialogTheme(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(16.0)),
        //     ),
        //   ),
        // ),
        home: GamePage(),
      ),
    );
  }
}

class _MyCupertinoApp extends _MyPlatformApp {
  _MyCupertinoApp({@required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: title,
    );
  }
}
