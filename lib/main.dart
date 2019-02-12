import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:SheelQuotient/Service/apiservice.dart';
import 'package:SheelQuotient/UI/auth/new_login.dart';
import 'package:SheelQuotient/UI/intro/intro.dart';
import 'package:SheelQuotient/UI/level/levelList.dart';
import 'package:SheelQuotient/app.dart';
import 'package:SheelQuotient/common.dart';
import 'package:SheelQuotient/constans/wsconstants.dart';
import 'package:SheelQuotient/model/cacheData.dart';
import 'package:SheelQuotient/model/user_state.dart';
import 'package:SheelQuotient/model/userinfo.dart';
import 'package:SheelQuotient/no-internet-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService _api = new ApiService();
Widget _defaultHome = new LoginPage();
StreamSubscription<ConnectivityResult> _subscription;

void main() async {
  await _checkLoginStatus();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(QuizApp(defaultHome: _defaultHome));
  });
  // await _checkLoginStatus();
}

_checkLoginStatus() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    print(' ------> inside NO internet ! <------');
    _defaultHome = NoInternetPage();
  } else if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
    print(' ------> inside internet <------');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isLogin = prefs.getBool('b_isUserLoggedIn') == null
        ? false
        : prefs.getBool('b_isUserLoggedIn');
    if (_isLogin) {
      print(json.decode(prefs.getString('user_info'))['data']);
      UserInfo userInfo =
          UserInfo.fromJson(json.decode(prefs.getString('user_info'))['data']);
      CacheData.userInfo = userInfo;
      await _loadUserState(CacheData.userInfo.mhtId);
    } else {
      _defaultHome = IntroPage();
    }
  }
  // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //   print(result);
  //   if (result == ConnectivityResult.none) {
  //     print(' ------> inside NO internet ! <------');
  //     _defaultHome = NoInternetPage();
  //   }
  // });
}

_loadUserState(int mhtId) async {
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

dispose() {
  _subscription.cancel();
}
