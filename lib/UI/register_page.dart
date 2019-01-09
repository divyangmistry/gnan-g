import 'dart:convert';

import 'package:flutter/material.dart';
import '../Service//apiservice.dart';

enum AlertType {
  Success,
  Error
}

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final String register = 'register';
  _RegisterData _data = new _RegisterData();
  ApiService _api = new ApiService();

  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text('REGISTER',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w300)),
    );
  }

  _bodyView() {
    return Form(
      key: _formKey,
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
              validator: (value) {
                if (value.isEmpty) {
                  return 'Name is required';
                }
                if (value.length < 3) {
                  return 'Name must be 3 character long';
                }
              },
              onSaved: (value) {
                _data.name = value;
              },
              decoration: new InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your Name',
                suffixIcon: new Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new TextFormField(
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
                // Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                // RegExp regex = new RegExp(pattern);
                if (value.isEmpty) {
                  return 'Email is required';
                }
                // else if (!regex.hasMatch(pattern)) {
                //   return 'Enter valid email';
                // }
              },
              onSaved: (value) {
                _data.email = value;
              },
              decoration: new InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your Email',
                suffixIcon: new Icon(Icons.person_outline),
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
                  onPressed: _register,
                  color: Theme.of(context).primaryColor,
                  child: new Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('REGISTER : ');
      print(_data.name);
      print(_data.mobile);
      print(_data.password);
      print(_data.email);
      var data;
      data = {
        "mobile": _data.mobile,
        "password": _data.password,
        "name": _data.name,
        "email": _data.email
      };
      _api.register(json.encode(data)).then((res) {
        if (res.statusCode == 201) {
          _showError('Success', json.decode(res.body)['msg'], false);
          print(json.decode(res.body).toString());
        } else {
          _showError('Error', json.decode(res.body)['msg'] ? json.decode(res.body)['msg'] : '', false);
        }
      });
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
    // TODO: implement build
    return new Scaffold(
      appBar: _appBarView(),
      body: _bodyView(),
    );
  }
}

class _RegisterData {
  String name;
  String mobile;
  String password;
  String email;
}
