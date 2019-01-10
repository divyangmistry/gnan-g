import 'package:flutter/material.dart';

class VerifyOTP extends StatefulWidget {
  final comeFrom;
  VerifyOTP(this.comeFrom);

  @override
  State<StatefulWidget> createState() {
    return new VerifyOTPState();
  }
}

class VerifyOTPState extends State<VerifyOTP> {
  final _formKey = GlobalKey<FormState>();
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
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  labelText: 'OTP',
                  hintText: 'Enter your OTP',
                  suffixIcon: new Icon(Icons.lock_open),
                  border: OutlineInputBorder()),
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
                onPressed: _verifyOTP,
                color: Theme.of(context).primaryColor,
                child: new Text(
                  'Verify OTP',
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

  void _verifyOTP() {
    // TODO: Implement verify OTP logic
    Navigator.pop(context);
    if (widget.comeFrom == 'register') {
      Navigator.pushReplacementNamed(context, '/simpleGame');
    } else {
      Navigator.pushReplacementNamed(context, '/forgotPassword');
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
