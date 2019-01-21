import 'package:flutter/material.dart';
import 'colors.dart';

// For override color for Form input
class AccentColorOverride extends StatelessWidget {
  final Color color;
  final Widget child;
  AccentColorOverride({Key key, this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context)
          .copyWith(accentColor: color, brightness: Brightness.dark),
    );
  }
}

// VeritialDivider
class CustomVerticalDivider extends StatelessWidget {
  final double height;
  CustomVerticalDivider({this.height: 40});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height,
      width: 1.0,
      color: kQuizMain50,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}

// Gredient APP background
class BackgroundGredient extends StatelessWidget {
  final Widget child;
  BackgroundGredient({this.child});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.9],
          colors: [
            kBackgroundGrediant1,
            kBackgroundGrediant2,
          ],
        ),
      ),
      child: child,
    );
  }
}

// App Loading Indicator
class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Opacity(
        opacity: 0.5,
        child: Scaffold(
          body: new Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
