import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../Service/apiservice.dart';

class LoginUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {
  final _formKey = GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  ApiService _api = new ApiService();

  _bodyView() {
    return new Form(
      key: _formKey,
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('LOGIN DATA');
      print('MOBILE : ${_data.mobile}');
      print('PASSWORD : ${_data.password}');

      var data;

      data = {'mobile': _data.mobile, 'password': _data.password};

      _api.login(json.encode(data)).then((res) {
        if (res.statusCode == 200) {
          SharedPreferences.getInstance().then((localstorage) {
            localstorage.setString(
                'user_info', (json.decode(res.body)['user_info']).toString());
          });
          print(json.decode(res.body)['user_info']);
        } else {
          _showError(json.decode(res.body)['msg']);
        }
      });
    }
  }

  void _showError(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext build) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}

class _LoginData {
  String mobile;
  String password;
}
