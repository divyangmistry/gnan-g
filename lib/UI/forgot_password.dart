import 'dart:convert';
import 'package:flutter/material.dart';
import '../Service/apiservice.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  _ForgotPasswordData _data = new _ForgotPasswordData();
  final _formKey = GlobalKey<FormState>();
  ApiService _api = new ApiService();
  bool _autoValidate = false;

  final _passwordController = new TextEditingController();

  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text(
        'FORGOT PASSWORD',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
      ),
    );
  }

  _bodyView() {
    return new Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: new Container(
        child: new ListView(
          padding: new EdgeInsets.all(20.0),
          children: <Widget>[
            new Image.asset(
              'images/planet.png',
              height: 200.0,
            ),
            new Padding(
              padding: EdgeInsets.only(top: 60.0),
            ),
            new TextFormField(
              controller: _passwordController,
              validator: (value) {
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
              },
              onSaved: (String value) {
                this._data.password = value;
              },
              obscureText: true,
              decoration: new InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  suffixIcon: new Icon(Icons.lock_open),
                  border: OutlineInputBorder()),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Password is required';
                } else if (value != _passwordController.text) {
                  return 'Password & Verify Password must be same';
                }
              },
              onSaved: (String value) {
                this._data.retypePassword = value;
              },
              obscureText: true,
              decoration: new InputDecoration(
                labelText: 'Verify Password',
                hintText: 'Verify your Password',
                suffixIcon: new Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new Container(
              height: 50.0,
              width: 15.0,
              child: new RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(300.0)),
                onPressed: _changePassword,
                color: Theme.of(context).primaryColor,
                child: new Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('FORGOT PASSWORD : ');
      print(_data.password);
      print(_data.retypePassword);
      var data;
      data = {
        'password': _data.password,
        'verifyPassword': _data.retypePassword
      };
      _api.forgotPassword(json.encode(data)).then((res) {
        if (res.statusCode == 201) {
          _showError('Success', json.decode(res.body)['msg'], false);
          print(json.decode(res.body).toString());
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          _showError(
              'Error',
              json.decode(res.body)['msg'] ? json.decode(res.body)['msg'] : '',
              false);
        }
      });
    } else {
      _autoValidate = true;
    }
  }

  void _showError(String title, String msg, bool showCancel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          title: Text(title, textAlign: TextAlign.center),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBarView(),
      body: _bodyView(),
    );
  }
}

class _ForgotPasswordData {
  String password;
  String retypePassword;
}
