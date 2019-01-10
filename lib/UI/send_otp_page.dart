import 'package:flutter/material.dart';

class SendOTP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SendOTPState();
  }
}

class SendOTPState extends State<SendOTP> {
  final _formKey = new GlobalKey<FormState>();
  final _mobileController = new TextEditingController();
  bool _autoValidate = false;

  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text(
        'OTP',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.w300,
        ),
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
              controller: _mobileController,
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
            ),
            new Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new Container(
              height: 50.0,
              width: 15.0,
              child: new RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(300.0),
                ),
                onPressed: _sendOTP,
                color: Theme.of(context).primaryColor,
                child: new Text(
                  'Send OTP',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendOTP() {
    // TODO : Generate OTP and send
    if (_formKey.currentState.validate()) {
      print(_mobileController.text);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/forgotPassword');
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
