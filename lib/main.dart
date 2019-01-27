import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/UI/auth/new_login.dart';
import 'package:kon_banega_mokshadhipati/UI/game_level.dart';
import 'package:kon_banega_mokshadhipati/UI/intro/intro.dart';
import 'package:kon_banega_mokshadhipati/UI/level/levelList.dart';
import 'package:kon_banega_mokshadhipati/app.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_state.dart';
import 'package:kon_banega_mokshadhipati/model/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _defaultHome = new LoginPage();
// Widget _defaultHome = new GameLevelPage();

void main() async {
  await _checkLoginStatus();
  runApp(QuizApp(defaultHome: _defaultHome));
}

_checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _isLogin = prefs.getBool('b_isUserLoggedIn') == null
      ? false
      : prefs.getBool('b_isUserLoggedIn');
  if (_isLogin) {
    UserInfo userInfo =
        UserInfo.fromJson(json.decode(prefs.getString('user_info'))['data']);
    CacheData.userInfo = userInfo;
    UserState userState = UserState.fromJson(
        json.decode(prefs.getString('userState'))['data']['results']);
    CacheData.userState = userState;
    _defaultHome = NewLevelPage();
  } else {
    _defaultHome = IntroPage();
  }
}
