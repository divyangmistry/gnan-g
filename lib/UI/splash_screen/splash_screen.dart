import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

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
        CommonFunction.startLoggedUserSession(context: context);
        Navigator.pushReplacementNamed(context, '/dashboardPage');
      } else {
        //Navigator.pushReplacementNamed(context, '/introPage');
        Navigator.pushReplacementNamed(context, '/login_new');
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'images/logo1.png',
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.5,
              ),
              SizedBox(height: 5),
              new CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
