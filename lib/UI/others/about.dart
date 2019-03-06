import 'package:GnanG/UI/widgets/base_state.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/constans/appconstant.dart';
import 'package:GnanG/utils/app_setting_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class _LinkText extends GestureDetector {
  _LinkText({TextStyle style, String url, String text})
      : super(
          child: Container(
            margin: EdgeInsets.all(1),
            padding: EdgeInsets.all(1),
            child: Text(
              text ?? url,
              style: style,
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                bottom:
                    new BorderSide(color: Colors.blue, style: BorderStyle.solid),
              ),
            ),
          ),
          onTap: () {
            launch(url, forceSafariVC: false);
          },
        );
}

final TextStyle linkStyle = TextStyle(
  color: Colors.blue,
  decoration: TextDecoration.none
 );

class About extends StatefulWidget {
  @override
  AboutState createState() {
    return new AboutState();
  }
}

class AboutState extends BaseState<About> {
  String appVersion = '';

  AboutState() {
    isLoading = true;
    AppSettingUtil.getAppVersion().then((version) {
      setState(() {
        appVersion = version;
        isLoading = false;
      });
    });
  }

  @override
  Widget pageToDisplay() {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("About Gnan-G"),
        backgroundColor: kBackgroundGrediant1,
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('images/logo1.png', height: MediaQuery.of(context).size.height/2,),
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
                    Text(appVersion),
                  ],
                ),
                SizedBox(height: 20),
                Text("Links", style: TextStyle(fontSize: 18),),
                SizedBox(height: 30),
                Text("For any query email us @", style: TextStyle(fontSize: 14),),
                SizedBox(height: 10),
                _LinkText(
                  style: linkStyle,
                  text: AppConstant.MBA_MAILID,
                  url: "mailto:" + AppConstant.MBA_MAILID +"?subject=Feedback of GnanG",
                ),
                SizedBox(height: 40),
                Text("Send Bug Report to us with screenshots @", style: TextStyle(fontSize: 14),),
                SizedBox(height: 10),
                _LinkText(
                  style: linkStyle,
                  text: "mbaapps@googlegroups.com",
                  url: "mailto:" + AppConstant.MBA_MAILID + "?subject=Bug Report of GnanG",
                ),
              ],
            ),
          )
        ]
      ));
  }
}