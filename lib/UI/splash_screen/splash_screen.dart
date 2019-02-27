import 'dart:convert';
import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/user_state.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors.dart';
import 'package:connectivity/connectivity.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashScreenState();
}

class SplashScreenState extends State<StatefulWidget> {
  ApiService _api = new ApiService();

  SplashScreenState() {
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print(' ------> inside NO internet ! <------');
      Navigator.pushReplacementNamed(context, '/noInternet');
    } else if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      print(' ------> inside internet <------');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _isLogin = prefs.getBool('b_isUserLoggedIn') == null
          ? false
          : prefs.getBool('b_isUserLoggedIn');
      if (_isLogin) {
        print(json.decode(prefs.getString('user_info'))['data']);
        UserInfo userInfo = UserInfo.fromJson(
            json.decode(prefs.getString('user_info'))['data']);
        CacheData.userInfo = userInfo;
        await _loadUserState(CacheData.userInfo.mhtId);
      } else {
        Navigator.pushReplacementNamed(context, '/introPage');
      }
    }
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
        Navigator.pushReplacementNamed(context, '/gameMainPage');
      }
    } catch (err) {
      print('CATCH 2 :: ERROR IN MAIN :: ');
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kQuizSurfaceWhite,
      body: new SafeArea(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Image.asset(
                'images/logo1.png',
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 4,
              ),
              new CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
