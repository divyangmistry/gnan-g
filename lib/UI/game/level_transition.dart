import 'package:flutter/material.dart';

class LevelTransitionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LevelTransitionPageState();
  }
}

class LevelTransitionPageState extends State<LevelTransitionPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                minRadius: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
                child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
