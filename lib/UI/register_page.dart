import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/UI/verify_otp_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  final String register = 'register';
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
                labelText: 'Name',
                hintText: 'Enter your Name',
                suffixIcon: new Icon(Icons.person_outline),
                border: OutlineInputBorder()),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          new TextFormField(
            obscureText: true,
            decoration: new InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your Password',
              suffixIcon: new Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          new TextFormField(
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              labelText: 'Mobile',
              suffixIcon: new Icon(Icons.phone_android),
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
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => new VerifyOTP(register: register)),
                    ),
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
