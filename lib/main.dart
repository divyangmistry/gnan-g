import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/Service/apiservice.dart';
import 'package:kon_banega_mokshadhipati/UI/auth/new_login.dart';
import 'package:kon_banega_mokshadhipati/UI/intro/intro.dart';
import 'package:kon_banega_mokshadhipati/UI/level/levelList.dart';
import 'package:kon_banega_mokshadhipati/app.dart';
import 'package:kon_banega_mokshadhipati/constans/wsconstants.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_state.dart';
import 'package:kon_banega_mokshadhipati/model/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService _api = new ApiService();
Widget _defaultHome = new LoginPage();

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
    await _loadUserState(CacheData.userInfo.mhtId);
  } else {
    _defaultHome = IntroPage();
  }
}

_loadUserState(mhtId) async {
  try {
    Response res = await _api.getUserState(mhtId: mhtId);
    if (res.statusCode == WSConstant.SUCCESS_CODE) {
      print('IN LOGIN ::: userstateStr ::: IN MAIN :: ');
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('userState', res.body);
      UserState userState =
          UserState.fromJson(json.decode(res.body)['data']['results']);
      CacheData.userState = userState;
      _defaultHome = NewLevelPage();
    }
  } catch (err) {
    print('CATCH 2 :: ERROR IN MAIN :: ');
    print(err);
  }
}
