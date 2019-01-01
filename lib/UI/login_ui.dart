import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginUIState();
  }
}

class LoginUIState extends State<LoginUI> {
  _bodyView() {
    return new Container(
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
            decoration: const InputDecoration(
                labelText: 'User Name:',
                hintText: 'Enter your Name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person_outline)),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          new TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
                labelText: 'Password:',
                hintText: 'Enter your Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.lock_outline,
                )),
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
              onPressed: () => Navigator.pushNamed(context, '/gamePage'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Theme.of(context).primaryColor,
              child: new Text('Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0)),
            ),
          ),
          new Padding(
            padding: EdgeInsets.all(20.0),
          ),
          new FlatButton(
            onPressed: () => Navigator.pushNamed(context, '/registerPage'),
            child: new Text(
              'Don\'t have LOGIN? Sign UP here !',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'LOGIN',
          style: new TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
      ),
      body: _bodyView(),
    );
  }
}
