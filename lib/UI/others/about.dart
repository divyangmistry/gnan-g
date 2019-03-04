import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:GnanG/constans/appconstant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:GnanG/colors.dart';

class _LinkText extends GestureDetector {

  _LinkText({ TextStyle style, String url, String text }) : super(
    child: Text(
      text ?? url,
      style: style,
    ),
    onTap: () {
      launch(url, forceSafariVC: false);
    }
  );
}

final TextStyle linkStyle = TextStyle(
  color: Colors.blue,
  decoration: TextDecoration.underline);

class About extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("About Gnan-G"),
        backgroundColor: kBackgroundGrediant1,
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('images/logo1.png',),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Version: ", style: TextStyle(color: kBackgroundGrediant3),),
                    Text(AppConstant.APP_VERSION),
                  ],
                ),
                SizedBox(height: 10),
                Text("Links", style: TextStyle(fontSize: 18),),
                SizedBox(height: 10),
                Text("For any query email us @", style: TextStyle(fontSize: 14),),
                SizedBox(height: 10),
                _LinkText(
                  style: linkStyle,
                  text: "mbaapps@googlegroups.com",
                  url: "mailto:mbaapps@googlegroups.com",
                ),
                SizedBox(height: 10),
                Text("Send Bug Report to us with screenshots @", style: TextStyle(fontSize: 14),),
                SizedBox(height: 10),
                _LinkText(
                  style: linkStyle,
                  text: "mbaapps@googlegroups.com",
                  url: "mailto:mbaapps@googlegroups.com",
                ),
              ],
            ),
          )
        ]
      ));
  }

}