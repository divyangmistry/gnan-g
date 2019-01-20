import 'package:flutter/material.dart';
import '../colors.dart';
import '../common.dart';
import '../Service/apiservice.dart';

class RegisterPage2 extends StatefulWidget {
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
                  validator: _verifyPasswordValidation,
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

  String _verifyPasswordValidation(value) {
    if (value.isEmpty) {
      return 'Verify Password is required';
    } else if (_passwordController.text != _verifyPasswordController.text) {
      return 'Password and Verifypassword must be same';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('PROFILE DATA');
      print('Password : ${this._passwordController.text}');
      print('VerifyPassword : ${this._verifyPasswordController.text}');
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/gameStart');
      // TODO : Implement SAVE user password
    } else {
      _autoValidate = true;
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
            titleAndData('Name : ', 'Milan Vadher'),
            SizedBox(height: 15),
            titleAndData('Mobile no. : ', '7574852413'),
            SizedBox(height: 15),
            titleAndData('Center : ', 'Sim-City'),
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
