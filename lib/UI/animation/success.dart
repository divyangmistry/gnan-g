import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SucessAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SucessAnimationState();
}

class SucessAnimationState extends State<SucessAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height / 2,
        // width: 200,
        child: FlareActor(
          'assets/animation/Dancing.flr',
          animation: "Flipflap",
        ),
      ),
    );
  }
}
