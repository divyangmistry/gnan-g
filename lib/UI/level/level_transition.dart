import 'package:flutter/material.dart';

class LevelTransitionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LevelTransitionPageState();
}

class LevelTransitionPageState extends State<LevelTransitionPage> {
  //ApiService apiService =
  int level = 2;
  int score = 450;
  int lives = 2;
  String imageName = 'images/Firework Icon 0';

  @override
  Widget build(BuildContext buildContext) {
    return new Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Congratulations',
              style: TextStyle(fontSize: 30.0, color: Colors.brown[400],),
            ),
          ),
          backgroundColor: Colors.blue,
        ),
//        backgroundColor: Colors.cyan,
        body:
        SafeArea(
//            height: 400,
//            width: 400,
//            margin: EdgeInsets.all(5.0),
            child: Column(
                children: <Widget>[
                  new SizedBox(
                      height: 50
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children :<Widget>[
                        new Container(
                          height: 300,
                          width: 300,
                          foregroundDecoration: BoxDecoration(border: Border.all(width: 1.0)),
                          child: Image.asset('images/Firework Icon 02.jpg'),
//                      child: Image.asset('bulb.png'),
                        ),
                      ]
                  ),
                  new SizedBox(
                      height: 25
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children :<Widget>[
                        new Text(
                          'U have cleared Level $level',
                          style: TextStyle(fontSize: 30.0, fontFamily: 'RobotoMono', color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ]
                  ),
                  new SizedBox(
                      height: 5
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          'Your Score is : $score',
                          style: TextStyle(fontSize: 30.0, fontFamily: 'monotype corsiva', color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                      ]
                  ),
                  new SizedBox(
                      height: 10
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          'U have $lives Remaining Lives.',
                          style: TextStyle(fontSize: 30.0, fontFamily: 'tahoma', color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ]
                  ),
                  new SizedBox(
                      height: 30
                  ),
                  RaisedButton(
                    child: const Text('Go to Next Level'),
                    color: Theme.of(context).accentColor,
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    onPressed: () {
                      // Perform some action
                      Navigator.pushReplacementNamed(context, '/level');
                    },
                  ),
                ]
            )
        )
    );
  }
}
