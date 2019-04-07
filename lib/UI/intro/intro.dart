import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  List<Widget> slides = [
    Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            'Title - 1',
            textScaleFactor: 2,
            style: TextStyle(color: kQuizBrown900),
          ),
          Expanded(
            child: Image.asset('images/logo1.png'),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              'Description some long long description that is so long that user can find details.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kQuizMain50),
              textScaleFactor: 1.2,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
    Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            'Title - 2',
            textScaleFactor: 2,
            style: TextStyle(color: kQuizBrown900),
          ),
          Expanded(
            child: Image.asset('images/TZLogo.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              'Description some long long description that is so long that user can find details.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kQuizMain50),
              textScaleFactor: 1.2,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
    Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            'Title - 3',
            textScaleFactor: 2,
            style: TextStyle(color: kQuizBrown900),
          ),
          Expanded(
            child: Image.asset('images/logo.png'),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              'Description some long long description that is so long that user can find details.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kQuizMain50),
              textScaleFactor: 1.2,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: slides.length,
      child: Scaffold(
        backgroundColor: kQuizSurfaceWhite,
        body: SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: TabBarView(
                      children: slides,
                    ),
                  ),
                  TabPageSelector(),
                  SizedBox(height: 20),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () async {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setBool('intro', true);
                            Navigator.pushReplacementNamed(
                                context, '/login_new');
                          },
                          child: Text(
                            'DIVE INTO GAME',
                            style: TextStyle(
                              color: kQuizBackgroundWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
