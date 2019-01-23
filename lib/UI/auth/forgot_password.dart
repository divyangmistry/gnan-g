import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Service/apiservice.dart';
import '../../common.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  _ForgotPasswordData _data = new _ForgotPasswordData();
  CommonFunction cf = new CommonFunction();

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
              validator: cf.passwordValidation,
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
                  return 'Verify Password is required';
                } else if (value != _passwordController.text) {
                  return 'Password and Verifypassword must be same';
                }
                return null;
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
          cf.alertDialog(
              context: context,
              barrierDismissible: false,
              title: 'Success',
              msg: json.decode(res.body)['msg'],
              showCancel: false,
              cancelButtonFn: null,
              doneButtonFn: null);
          print(json.decode(res.body).toString());
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          cf.alertDialog(
              context: context,
              barrierDismissible: false,
              title: 'Error',
              msg: json.decode(res.body)['msg']
                  ? json.decode(res.body)['msg']
                  : '',
              showCancel: false,
              cancelButtonFn: null,
              doneButtonFn: null);
        }
      });
    } else {
      _autoValidate = true;
    }
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
