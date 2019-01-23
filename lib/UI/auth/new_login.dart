// Package import
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// File import
import '../../common.dart';
import '../../Service/apiservice.dart';
import '../../colors.dart';
import '../../constans/sharedpref_constant.dart';
import '../../model/cacheData.dart';
import '../../model/user_state.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  CommonFunction cf = new CommonFunction();

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _obscureText = true;
  ApiService _api = new ApiService();
  String _mhtId;
  String _password;

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
                    'SIGN IN',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              new SizedBox(
                height: 50.0,
              ),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  validator: cf.mhtIdValidation,
                  decoration: InputDecoration(
                    labelText: 'Mht Id',
                    hintText: 'Enter Mht Id no.',
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: kQuizBrown900,
                    ),
                    filled: true,
                  ),
                  onSaved: (String value) {
                    _mhtId = value;
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ),
              new SizedBox(height: 20.0),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  validator: cf.passwordValidation,
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
                  onSaved: (String value) {
                    _password = value;
                  },
                  obscureText: _obscureText,
                ),
              ),
              new SizedBox(height: 20.0),
              new RaisedButton(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 4.0,
                padding: EdgeInsets.all(20.0),
                onPressed: _submit,
              ),
              new SizedBox(height: 50.0),
              _signupBox(),
              new SizedBox(height: 15.0),
              _termsAndCondition(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupBox() {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            'Don\'t have an account?',
            style: TextStyle(color: kQuizMain50),
          ),
          new FlatButton(
            child: new Text(
              'SIGN UP NOW',
              style: TextStyle(
                color: kQuizBrown900,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
          ),
        ],
      ),
    );
  }

  Widget _termsAndCondition() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FlatButton(
            child: new Text(
              'Terms and Conditions',
              style: TextStyle(color: kQuizMain50),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/t&c');
            },
          ),
        ],
      ),
    );
  }

  void _submit() {
    print('In Submit');
    cf.alertDialog(context: context,title: 'Title', msg: 'Testing',showCancel: true, cancelButtonFn: null, doneButtonFn: onClickDone);
    // _showError('msg', true);
    // Navigator.pushNamed(context, '/level_new');
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    //   print('LOGIN DATA');
    //   print('MOBILE : ${this._mhtId}');
    //   print('PASSWORD : ${this._password}');
    //   Navigator.pushReplacementNamed(context, '/game_new');
    //   // var data = {'mobile': _mhtId, 'password': _password};
    //   // _api.login(json.encode(data)).then((res) {
    //   //   if (res.statusCode == 200) {
    //   //     SharedPreferences.getInstance().then((localstorage) {
    //   //       localstorage.setString('user_info', res.body);
    //   //       localstorage.setBool(SharedPrefConstant.b_isUserLoggedIn, true);
    //   //     });
    //   //     print(json.decode(res.body)['user_info']);
    //   //     _loadUserState(_mhtId);
    //   //   } else {
    //   //     _showError(json.decode(res.body)['msg'], true);
    //   //   }
    //   // });
    // } else {
    //   _autoValidate = true;
    // }
  }

  onClickDone() {
    print('Done');
    Navigator.pop(context);
  }

  onClickClose() {
    print('Close');
    Navigator.pop(context);
  }

  _loadUserState(mhtId) async {
    var data = {'user_mob': mhtId};
    Response res = await _api.getUserState(json.encode(data));
    if (res.statusCode == 200) {
      Map<String, dynamic> userstateStr = json.decode(res.body)['results'];
      print('IN LOGIN ::: userstateStr :::');
      print(userstateStr);
      UserState userState = UserState.fromJson(userstateStr);
      CacheData.userState = userState;
      Navigator.pushReplacementNamed(context, '/level');
    } else {
      print('ERROR : ');
      print(res.body);
    }
  }

}
