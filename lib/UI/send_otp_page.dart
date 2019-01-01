import 'package:flutter/material.dart';

class SendOTP extends StatefulWidget {
  var register;
  SendOTP({this.register});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SendOTPState();
  }
}

class SendOTPState extends State<SendOTP> {
  _appBarView() {
    return new AppBar(
      centerTitle: true,
      title: new Text('OTP',
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
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
                labelText: 'Mobile',
                hintText: 'Enter your Mobile Number',
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
                    borderRadius: BorderRadius.circular(300.0)),
                onPressed: () =>
                    Navigator.pushNamed(context, '/verifyOtp'),
                // debugPrint("push"),
                color: Theme.of(context).primaryColor,
                child: new Text(
                  'Send OTP',
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
