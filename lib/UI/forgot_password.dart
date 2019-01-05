import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text('FORGOT PASSWORD',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300)),
    );
  }

  _bodyView() {
    return new Container(
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
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/login', ModalRoute.withName('/login')),
                color: Theme.of(context).primaryColor,
                child: new Text(
                  'Reset Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                )),
          ),
        ],
      ),
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
