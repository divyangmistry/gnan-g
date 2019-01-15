import 'package:flutter/material.dart';

class RulesPagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RulesPagePageState();
}

class RulesPagePageState extends State<RulesPagePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: new Center(
          child: new Text('Rules Page ... !!'),
        ),
      ),
    );
  }
}