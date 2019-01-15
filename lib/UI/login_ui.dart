import 'dart:convert';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/UI/verify_otp_page.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../Service/apiservice.dart';
import '../constans/sharedpref_constant.dart';

class LoginUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {
  final _formKey = GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  ApiService _api = new ApiService();
  bool _autoValidate = false;

  _bodyView() {
    return new Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            new Image.asset(
              'images/face.png',
              height: 250.0,
            ),
            new Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Mobile no. is required';
                } else if (value.length != 10) {
                  return 'Mobile no. must have 10 digit';
                }
              },
              keyboardType: TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                labelText: 'Mobile no.:',
                hintText: 'Enter your Mobile no.',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person_outline),
              ),
              onSaved: (String value) {
                this._data.mobile = value;
              },
            ),
            new Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              validator: (value) {
                Pattern pattern =
                    r'(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$';
                // Pattern pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$';
                RegExp regex = new RegExp(pattern);
                if (value.isEmpty) {
                  return 'Password is required';
                } else if (value.length < 6) {
                  return 'Passwords must contain at least six characters';
                } else if (!regex.hasMatch(value)) {
                  return 'Passwords must contain uppercase, lowercase letters and numbers';
                }
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password:',
                hintText: 'Enter your Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.lock_outline,
                ),
              ),
              onSaved: (String value) {
                this._data.password = value;
              },
            ),
            new FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/sendOtp'),
              child: new Text(
                'Did you Forgot Password ?',
                style: new TextStyle(color: Colors.grey),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(20.0),
            ),
            new Container(
              height: 50.0,
              width: 15.0,
              child: new RaisedButton(
                onPressed: _login,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Theme.of(context).primaryColor,
                child: new Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(20.0),
            ),
            new FlatButton(
              child: new Text(
                'Don\'t have LOGIN? Sign UP here !',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/registerPage'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'LOGIN',
            style: new TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
        ),
        body: _bodyView(),
      );

  void _login() {
    Navigator.pushReplacementNamed(context, '/gameStart');
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    //   print('LOGIN DATA');
    //   print('MOBILE : ${_data.mobile}');
    //   print('PASSWORD : ${_data.password}');

    //   var data;

    //   data = {'mobile': _data.mobile, 'password': _data.password};

    //   _api.login(json.encode(data)).then((res) {
    //     if (res.statusCode == 200) {
    //       SharedPreferences.getInstance().then((localstorage) {
    //         localstorage.setString('user_info', res.body);
    //         localstorage.setBool(SharedPrefConstant.b_isUserLoggedIn, true);
    //       });
    //       print(json.decode(res.body)['user_info']);
    //       _loadUserState(_data.mobile);
    //     } else {
    //       _showError(json.decode(res.body)['msg'], true);
    //     }
    //   });
    // } else {
    //   _autoValidate = true;
    // }
  }

  _loadUserState(mobile) async {
    var data = {'user_mob': mobile};
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

class _LoginData {
  String mobile;
  String password;
}
