// Package import
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// File import
import '../Service/apiservice.dart';
import '../colors.dart';
import '../constans/sharedpref_constant.dart';
import '../model/cacheData.dart';
import '../model/user_state.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
        backgroundColor: kQuizBackgroundWhite,
        body: SafeArea(
          child: new ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              new SizedBox(
                height: 60.0,
              ),
              new Column(
                children: <Widget>[
                  new Image.asset(
                    'images/logo1.png',
                    height: 150,
                  ),
                ],
              ),
              new SizedBox(
                height: 60.0,
              ),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  validator: _mhtIdValidation,
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
                  validator: _passwordValidation,
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
                        _obscureText ? Icons.visibility : Icons.visibility_off,
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
              new SizedBox(height: 30.0),
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
            style: TextStyle(color: Colors.grey),
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
              Navigator.pushNamed(context, '/registerPage');
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
              style: TextStyle(color: Colors.grey),
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('LOGIN DATA');
      print('MOBILE : ${this._mhtId}');
      print('PASSWORD : ${this._password}');
      Navigator.pushNamed(context, '/gameStart');
      // var data = {'mobile': _mhtId, 'password': _password};
      // _api.login(json.encode(data)).then((res) {
      //   if (res.statusCode == 200) {
      //     SharedPreferences.getInstance().then((localstorage) {
      //       localstorage.setString('user_info', res.body);
      //       localstorage.setBool(SharedPrefConstant.b_isUserLoggedIn, true);
      //     });
      //     print(json.decode(res.body)['user_info']);
      //     _loadUserState(_mhtId);
      //   } else {
      //     _showError(json.decode(res.body)['msg'], true);
      //   }
      // });
    } else {
      _autoValidate = true;
    }
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

  String _mhtIdValidation(value) {
    if (value.isEmpty) {
      return 'Mht ID is required';
    } else if (value.length != 6) {
      return 'Mht ID must have 6 digit';
    }
    return null;
  }

  String _passwordValidation(value) {
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

  void _showError(String msg, bool showCancel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          title: Text('Error', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                msg,
                style: TextStyle(color: Colors.blueGrey),
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  showCancel
                      ? FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                size: 22.0,
                                color: Colors.blue[900],
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Cancel',
                                style: TextStyle(color: Colors.blue[900]),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : new Container(width: 0, height: 0),
                  showCancel
                      ? SizedBox(
                          width: 10.0,
                        )
                      : new Container(width: 0, height: 0),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.blue[900],
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.done,
                          size: 22.0,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Try Again',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context)
          .copyWith(accentColor: color, brightness: Brightness.dark),
    );
  }
}
