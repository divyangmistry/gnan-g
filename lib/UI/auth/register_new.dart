import 'package:GnanG/constans/sharedpref_constant.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/signupsession.dart';
import 'package:GnanG/notification/notifcation_setup.dart';
import '../../colors.dart';
import '../../common.dart';
import '../../Service/apiservice.dart';

class RegisterPage2 extends StatefulWidget {
  final bool fromForgotPassword;
  final UserData userData;

  RegisterPage2({this.userData, this.fromForgotPassword = false});
  @override
  State<StatefulWidget> createState() => new RegisterPage2State();
}

class RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _obscureText = true;
  bool _obscureText1 = true;
  ApiService _api = new ApiService();
  final _passwordController = new TextEditingController();
  final _verifyPasswordController = new TextEditingController();
  CommonFunction cf = new CommonFunction();

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: new Scaffold(
        backgroundColor: kQuizSurfaceWhite,
        body: SafeArea(
          child: new ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              new SizedBox(height: 40.0),
              new Column(
                children: <Widget>[
                  new Image.asset(
                    'images/logo1.png',
                    height: 150,
                  ),
                  new SizedBox(height: 30.0),
                  new Text(
                    'REGISTER - STEP: 2',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              profileData(),
              new SizedBox(
                height: 20.0,
              ),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  controller: _passwordController,
                  validator: CommonFunction.passwordValidation,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: kQuizBrown900,
                    ),
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        semanticLabel:
                            _obscureText ? 'show password' : 'hide password',
                        color: kQuizBrown900,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
              ),
              new SizedBox(height: 20.0),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  controller: _verifyPasswordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Verify Password is required';
                    } else if (value != _passwordController.text) {
                      return 'Password and Verifypassword must be same';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Verify Password',
                    hintText: 'Enter Password',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: kQuizBrown900,
                    ),
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                        semanticLabel:
                            _obscureText1 ? 'show password' : 'hide password',
                        color: kQuizBrown900,
                      ),
                    ),
                  ),
                  obscureText: _obscureText1,
                ),
              ),
              new SizedBox(height: 20.0),
              new RaisedButton(
                child: Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 4.0,
                padding: EdgeInsets.all(20.0),
                onPressed: _submit,
              ),
              new SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      if (widget.fromForgotPassword) {
        _resetPassword();
      } else {
        _registerUser();
      }
    } else {
      _autoValidate = true;
    }
  }

  _registerUser() async {
    try {
      widget.userData.password = _passwordController.text.toString();
      Response res = await _api.register(userData: widget.userData);
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        UserInfo userInfo = UserInfo.fromJson(appResponse.data);
        CacheData.userInfo = userInfo;
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user_info', res.body);
        pref.setString('token', userInfo.token);
        pref.setBool(SharedPrefConstant.b_isUserLoggedIn, true);
        NotificationSetup.setupNotification();
        CommonFunction.loadUserState(context, userInfo.mhtId);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/level_new');
      }
    } catch (err) {
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
  }

  _resetPassword() async {
    try {
      Response res = await _api.updatePassword(
          mhtId: widget.userData.mhtId, password: _passwordController.text);
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user_info', res.body);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/level_new');
      }
    } catch (err) {
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
  }

  profileData() {
    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[50],
      elevation: 4,
      child: new Padding(
        padding: EdgeInsets.all(30),
        child: new Column(
          children: <Widget>[
            Text(
              'Profile data',
              textScaleFactor: 1.5,
            ),
            SizedBox(height: 30),
            titleAndData('Name : ', widget.userData.name),
            SizedBox(height: 15),
            titleAndData('Mobile no. : ', widget.userData.mobile),
            SizedBox(height: 15),
            titleAndData('Email id : ', widget.userData.email),
            SizedBox(height: 15),
            titleAndData('Center : ', widget.userData.center),
          ],
        ),
      ),
    );
  }

  Widget titleAndData(String title, String data) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width / 3,
              child: new Text(
                title,
                textScaleFactor: 1.1,
                style: TextStyle(
                  color: kQuizMain50,
                ),
              ),
            ),
            new Text(
              data,
              textScaleFactor: 1.2,
            ),
          ],
        ),
      ],
    );
  }
}
