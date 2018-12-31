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
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        children: <Widget>[
          new Image.asset(
            'images/face.png',
            height: 250.0,
          ),
          new Padding(
            padding: EdgeInsets.all(20.0),
          ),
          new TextFormField(
            decoration: const InputDecoration(
                labelText: 'User Name:',
                hintText: 'Enter your Name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person_outline)),
          ),
          new Padding(
            padding: EdgeInsets.all(20.0),
          ),
          // new PasswordField()
          new TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
                labelText: 'Password:',
                hintText: 'Enter your Password',
                border: OutlineInputBorder(),
                suffixIcon:
                    // GestureDetector(onTap: (){},),
                    Icon(
                  Icons.lock_outline,
                )),
          ),
          new FlatButton(
            onPressed: () => debugPrint("Forgot Password"),
            child: new Text(
              'Did you Forgot Password ?',
              style: new TextStyle(color: Colors.grey),
            ),
          ),
          new Padding(
            padding: EdgeInsets.all(20.0),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new MaterialButton(
                onPressed: () => Navigator.pushNamed(context, '/gameUI'),
                shape: CircleBorder(),
                color: Colors.green.shade600,
                child: new Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // new Padding(
          //   padding: EdgeInsets.all(2.0),
          // ),
          new FlatButton(
            onPressed: () => debugPrint("Cancle"),
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
