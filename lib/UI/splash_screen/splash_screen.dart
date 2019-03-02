import 'dart:convert';
import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/user_state.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:GnanG/utils/appsharedpref.dart';
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
      if (await AppSharedPrefUtil.isUserLoggedIn()) {
        UserInfo userInfo = await AppSharedPrefUtil.getUserInfo();
        CacheData.userInfo = userInfo;
        await CommonFunction.loadUserState(context, CacheData.userInfo.mhtId);
        Navigator.pushReplacementNamed(context, '/gameMainPage');
      } else {
        Navigator.pushReplacementNamed(context, '/introPage');
      }
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
