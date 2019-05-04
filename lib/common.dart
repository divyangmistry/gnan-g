import 'dart:convert';

import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/constans/appconstant.dart';
import 'package:GnanG/constans/message_constant.dart';
import 'package:GnanG/constans/sharedpref_constant.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/main.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/user_score_state.dart';
import 'package:GnanG/model/user_state.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:GnanG/notification/notifcation_setup.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:GnanG/utils/audio_utilsdart.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
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
      data: Theme.of(context).copyWith(accentColor: color, brightness: Brightness.dark),
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

// Gredient APP background
class BackgroundGredientGame extends StatelessWidget {
  final Widget child;

  BackgroundGredientGame({@required this.child}) : assert(child != null);

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
            kBackgroundGrediant3,
            kBackgroundGrediant4,
          ],
        ),
      ),
      child: child,
    );
  }
}

// App Loading Indicator
class CustomLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final bool isOverlay;

  CustomLoading({@required this.isLoading, @required this.child, this.isOverlay = false});

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        isOverlay ? child : !isLoading ? child : new Container(),
        isLoading
            ? new Stack(
                children: [
                  new Opacity(
                    opacity: 0.5,
                    child: const ModalBarrier(
                      dismissible: false,
                      color: kQuizBrown900,
                    ),
                  ),
                  new Center(
                    child: SpinKitThreeBounce(
                      color: kQuizBackgroundWhite,
                      size: 50.0,
                    ),
                  ),
                ],
              )
            : new Container(),
      ],
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
    }
    return null;
  }

  // password Validation
  static String passwordValidation(String value) {
//    Pattern pattern =
//        r'(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$';
//    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 4) {
      return 'Passwords must contain at least 4 characters';
    }
//    else if (!regex.hasMatch(value)) {
//      return 'Passwords must contain uppercase, lowercase letters and numbers';
//    }
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
  static String mobileValidation(String value) {
    if (value.isEmpty) {
      return 'Mobile no. is required';
    } else if (value.length != 10) {
      return 'Enter valid Mobile no.';
    }
    return null;
  }

  // email Validation
  static String emailValidation(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email-Id is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid Email-Id';
    }
    return null;
  }

  // Feedback contact validation
  static String contactValidation(String value) {
    if (value.isEmpty) {
      return 'Contact is required';
    }
    return null;
  }

  // Feedback message validation
  static String messageValidation(String value) {
    if (value.isEmpty) {
      return 'Message is required';
    }
    return null;
  }

  static saveUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user_info', json.encode(CacheData.userInfo.toJson()));
  }

  // points ui
  static Widget pointsUI({@required BuildContext context, String point = '100'}) {
    return GestureDetector(
      child: new Container(
        height: 35,
        padding: EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(25),
        ),
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
            SizedBox(width: 15),
            Image.asset('images/coin.png', height: 20),
          ],
        ),
      ),
      onTap: () {
        if (CacheData.userState.lives >= 3) {
          CommonFunction.alertDialog(context: context, msg: 'You have enough lives !!', type: 'success');
        } else {
          CommonFunction.alertDialog(
            context: context,
            msg: 'You can buy life for 100 points.',
            doneButtonText: 'Yes take it',
            type: 'success',
            title: 'Oh Yeah ..',
            playSound: false,
            barrierDismissible: false,
            showCancelButton: true,
            doneButtonFn: () {
              getLife(context);
            },
          );
        }
      },
    );
  }

  static Future<bool> getLife(BuildContext context) async {
    try {
      Response res = await _api.requestLife(mhtId: CacheData.userInfo.mhtId);
      AppResponse appResponse = ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        UserScoreState userState = UserScoreState.fromJson(appResponse.data);
        userState.updateSessionScore();
        Navigator.pop(context);
        main();
        return true;
      }
    } catch (e) {
      CommonFunction.displayErrorDialog(context: context, msg: e.toString());
    }
    return false;
  }

  static displayErrorDialog({@required BuildContext context, String msg}) {
    if (msg == null) msg = MessageConstant.COMMON_ERROR_MSG;
    alertDialog(
      context: context,
      msg: msg,
      barrierDismissible: false,
    );
  }

  static Future<bool> loadUserState(BuildContext context, int mhtId) async {
    Response res = await _api.getUserState(mhtId: mhtId);
    AppResponse appResponse = ResponseParser.parseResponse(context: context, res: res);
    try {
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        print('IN LOGIN ::: userstateStr :::');
        SharedPreferences pref = await SharedPreferences.getInstance();
        print('res.body :: ');
        print(res.body);
        pref.setString('userState', res.body);
        UserState userState = UserState.fromJson(appResponse.data['results']);
        CacheData.userState = userState;
        return true;
      }
    } catch (err) {
      print('CATCH 2 :: ');
      print(err);
      var data = res.body;
      print(data);
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
      return false;
    }
  }

  static Future<bool> startUserSession({@required UserInfo userInfo, @required String strUserInfo, BuildContext context}) async {
    CacheData.userInfo = userInfo;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user_info', strUserInfo);
    pref.setString('token', userInfo.token);
    pref.setBool(SharedPrefConstant.b_isUserLoggedIn, true);
    print(userInfo);
    _api.appendTokenToHeader(userInfo.token);
    await NotificationSetup.setupNotification(userInfo: userInfo, context: context);
    await CommonFunction.loadUserState(context, userInfo.mhtId);
    await AppSharedPrefUtil.saveMuteEnabled(false);
    AppAudioUtils.startBackgroundMusic();
    return true;
  }

  static Future<Image> getUserProfileImg({BuildContext context}) async {
    Image userProfile;
    userProfile = await AppSharedPrefUtil.getProfileImage();
    if (userProfile == null) {
      String base64Img = await getProfilePictureFromServer(context, CacheData.userInfo.mhtId);
      userProfile = getImageFromBase64Img(base64Img: base64Img);
      AppSharedPrefUtil.saveProfileImage(base64Img);
    }
    if (userProfile == null) userProfile = Image(image: AssetImage(AppConstant.DEFAULT_USER_IMG_PATH));
    return userProfile;
  }

  static Future<String> getProfilePictureFromServer(BuildContext context, int mhtId) async {
    String profileBase64Image;
    Response res = await _api.getProfilePicture(mhtId: mhtId);
    AppResponse appResponse = ResponseParser.parseResponse(context: context, res: res);
    if (appResponse.status == WSConstant.SUCCESS_CODE) {
      profileBase64Image = appResponse.data['image'];
    }
    return profileBase64Image;
  }

  static Image getImageFromBase64Img({@required String base64Img, bool returnDefault = false}) {
    Image image;
    if (base64Img != null) image = Image(image: MemoryImage(base64Decode(base64Img)));
    if (returnDefault && image == null) image = CacheData.getUserDefaultImg();
    return image;
  }

  // common Alert dialog
  static alertDialog({
    @required BuildContext context,
    String type = 'error', // 'success' || 'error' || 'info'
    String title,
    @required String msg,
    bool showDoneButton = true,
    String doneButtonText = 'Okay',
    Function doneButtonFn,
    bool barrierDismissible = true,
    bool showCancelButton = false,
    Function doneCancelFn,
    String cancelButtonText = 'Cancel',
    AlertDialog Function() builder,
    Widget widget,
    bool displayImage = true,
    bool playSound = true,
  }) {
    AppConstant.POPUP_COUNT += 1;
    if (type == 'error' && playSound) {
      AppAudioUtils.playWrongMusic();
    } else if (type == 'success' && playSound) {
      if (playSound) AppAudioUtils.playCorrectMusic();
    }
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                displayImage
                    ? Container(
                        height: 150,
                        width: 150,
                        child: FlareActor(
                          'assets/animation/Teddy.flr',
                          animation: type == 'success' ? "success" : 'fail',
                        ),
                      )
                    : new Container(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    msg != null
                        ? msg
                        : type == 'error' ? "Looks like your lack of \n Imagination ! " : "Looks like today is your luckyday ... !!",
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
                      color: type == 'error' ? kQuizErrorRed : kQuizMain500,
                      child: Row(
                        children: <Widget>[
                          Text(
                            doneButtonText != null ? doneButtonText : type == 'error' ? "Okeh..." : "Hooray!",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              color: kQuizBackgroundWhite,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        AppConstant.POPUP_COUNT -= 1;
                        if (playSound && type == 'success') AppAudioUtils.stopCorrectMusic();
                        if (doneButtonFn != null) {
                          doneButtonFn();
                        } else {
                          Navigator.pop(context);
                        }
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
                                  cancelButtonText,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                    color: kQuizBackgroundWhite,
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              AppConstant.POPUP_COUNT -= 1;
                              if (playSound && type == 'success') AppAudioUtils.stopCorrectMusic();
                              if (doneCancelFn != null) {
                                doneCancelFn();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          )
                        : new Container(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget titleAndData(BuildContext context, String title, String data) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width / 4,
              child: new Text(
                title,
                textScaleFactor: 1.1,
                style: TextStyle(
                  color: kQuizMain50,
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: new Text(
                data != null ? data : "",
                overflow: TextOverflow.fade,
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: kQuizMain400,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
