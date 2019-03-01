import 'dart:math';

import 'package:GnanG/colors.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as radians;

class FabAnimatedButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FabAnimatedButtonState();
  }
}

class FabAnimatedButtonState extends State<FabAnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(
          milliseconds: 500,
        ),
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RadialAnimation(
      controller: controller,
    );
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
      : scale = Tween<double>(begin: 1.5, end: 0.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
        translation = Tween<double>(begin: 0.0, end: 100.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
        rotaton = Tween<double>(begin: 0.0, end: 360.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.7, curve: Curves.decelerate))),
        super(key: key);
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final Animation<double> rotaton;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: radians.radians(rotaton.value),
          child: Stack(
            children: <Widget>[
              _buildButton(0, color: Colors.blue, icon: Icon(Icons.person)),
              _buildButton(180,
                  color: Colors.blue, icon: Icon(Icons.person_add)),
              Transform.scale(
                scale: scale.value - 1.5,
                child: FloatingActionButton(
                  child: Icon(Icons.more_horiz),
                  onPressed: _close,
                  backgroundColor: Colors.red,
                ),
              ),
              Transform.scale(
                scale: scale.value,
                child: FloatingActionButton(
                  child: Icon(Icons.more_vert),
                  onPressed: _open,
                  backgroundColor: Colors.blue,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _buildButton(double angle, {Color color, Icon icon}) {
    final double rad = radians.radians(angle);

    return Transform(
      transform: Matrix4.identity()
        ..translate(
            (translation.value) * cos(rad), (translation.value) * sin(rad)),
      child: FloatingActionButton(
        child: Icon(Icons.person_add),
        backgroundColor: color,
        onPressed: _close,
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
