import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:SheelQuotient/Service/apiservice.dart';
import 'package:SheelQuotient/UI/puzzle/main.dart';
import 'package:SheelQuotient/constans/appconstant.dart';
import 'package:SheelQuotient/constans/message_constant.dart';
import 'package:SheelQuotient/constans/wsconstants.dart';
import 'package:SheelQuotient/model/appresponse.dart';
import 'package:SheelQuotient/model/cacheData.dart';
import 'package:SheelQuotient/model/userinfo.dart';
import 'package:SheelQuotient/utils/response_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';

// For override color for Form input
class AccentColorOverride extends StatelessWidget {
  final Color color;
  final Widget child;
  AccentColorOverride({Key key, @required this.color, @required this.child})
      : assert(color != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context)
          .copyWith(accentColor: color, brightness: Brightness.dark),
    );
  }
}

// VeritialDivider
class CustomVerticalDivider extends StatelessWidget {
  final double height;
  CustomVerticalDivider({this.height: 40});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height,
      width: 1.0,
      color: kQuizMain50,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}

// Gredient APP background
class BackgroundGredient extends StatelessWidget {
  final Widget child;
  BackgroundGredient({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.9],
          colors: [
            kBackgroundGrediant1,
            kBackgroundGrediant2,
          ],
        ),
      ),
      child: child,
    );
  }
}

// App Loading Indicator
class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Opacity(
        opacity: 0.5,
        child: Scaffold(
          body: new Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

// *********************************** //
// *********************************** //
// *********************************** //
// *********************************** //

// All common functions
class CommonFunction {
  static ApiService _api = new ApiService();

  // mhtId Validation
  static String mhtIdValidation(value) {
    if (value.isEmpty) {
      return 'Mht ID is required';
    } else if (value.length != 6) {
      return 'Mht ID must have 6 digit';
    }
    return null;
  }

  // password Validation
  static String passwordValidation(value) {
    Pattern pattern =
        r'(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Passwords must contain at least six characters';
    } else if (!regex.hasMatch(value)) {
      return 'Passwords must contain uppercase, lowercase letters and numbers';
    }
    return null;
  }

  // otp Validation
  static String otpValidation(String value) {
    if (value.isEmpty) {
      return 'OTP is required';
    } else if (value.length != 6) {
      return 'OTP must have 6 digit';
    }
    return null;
  }

  // mobile Validation
  static String mobileValidation(value) {
    if (value.isEmpty) {
      return 'Mobile no. is required';
    } else if (value.length != 10) {
      return 'Enter Valid Mobile no.';
    }
    return null;
  }

  static saveUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user_info', json.encode(CacheData.userInfo.toJson()));
  }

  // points ui
  static Widget pointsUI(
      {@required BuildContext context, String point = '100'}) {
    return GestureDetector(
      child: new Container(
        height: 40,
        padding: EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
            color: kQuizSurfaceWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 5.0, offset: Offset(-2, 2))
            ]),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 1),
            Text(
              point,
              style: TextStyle(
                color: kQuizMain400,
              ),
              textScaleFactor: 1.5,
            ),
            SizedBox(width: 5),
            Image.asset('images/coin.png', height: 20),
          ],
        ),
      ),
      onTap: () {
        CommonFunction.alertDialog(
          context: context,
          msg: 'You can buy life from 100 points.',
          doneButtonText: 'Yes take it',
          type: 'success',
          title: 'Oh Yeah ..',
          barrierDismissible: false,
          showCancelButton: true,
          doneButtonFn: () {
            _getLife(context);
          },
        );
      },
    );
  }

  static _getLife(BuildContext context) async {
    Response res = await _api.requestLife(mhtId: CacheData.userInfo.mhtId);
    AppResponse appResponse =
        ResponseParser.parseResponse(context: context, res: res);
    if (appResponse.status == WSConstant.SUCCESS_CODE) {
      // TODO : IMPLEMENT res
    }
  }

  static displayErrorDialog({@required BuildContext context, String msg}) {
    if (msg == null) msg = MessageConstant.COMMON_ERROR_MSG;
    alertDialog(
      context: context,
      msg: msg,
      barrierDismissible: false,
    );
  }

  // common Alert dialog
  static alertDialog({
    @required BuildContext context,
    String type = 'error', // 'success' || 'error'
    String title,
    @required String msg,
    bool showDoneButton = true,
    String doneButtonText = 'Okeh...',
    Function doneButtonFn,
    bool barrierDismissible = true,
    bool showCancelButton = false,
    AlertDialog Function() builder,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return AlertDialog(
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(type == 'error' ? Icons.mood_bad : Icons.tag_faces,
                  size: 100),
              SizedBox(height: 20),
              Text(
                title != null
                    ? title
                    : type == 'error' ? 'Oh No!' : 'Congratulations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: type == 'error' ? kQuizErrorRed : Colors.green[600],
                ),
                textScaleFactor: 1.5,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  msg != null
                      ? msg
                      : type == 'error'
                          ? "Looks like your lack of \n Imagination ! "
                          : "Looks like today is your luckyday ... !!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, height: 1.5),
                  textScaleFactor: 1.1,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    color: type == 'error' ? kQuizErrorRed : Colors.green[600],
                    child: Row(
                      children: <Widget>[
                        Text(
                          doneButtonText != null
                              ? doneButtonText
                              : type == 'error' ? "Okeh..." : "Hooray!",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: kQuizBackgroundWhite,
                          ),
                        )
                      ],
                    ),
                    onPressed: doneButtonFn != null
                        ? doneButtonFn
                        : () {
                            Navigator.pop(context);
                          },
                  ),
                  showCancelButton ? SizedBox(width: 10) : new Container(),
                  showCancelButton
                      ? FlatButton(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          color: kQuizErrorRed,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Cancel",
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  color: kQuizBackgroundWhite,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : new Container(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
