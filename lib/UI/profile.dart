import 'package:flutter/material.dart';

class ProfilePagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProfilePagePageState();
}

class ProfilePagePageState extends State<ProfilePagePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: new Center(
          child: new Text('Profile Page ... !!'),
        ),
      ),
    );
  }
}