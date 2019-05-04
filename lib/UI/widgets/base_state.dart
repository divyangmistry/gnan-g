import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool isLoading = false;
  bool isOverlay = false;

  @override
  Widget build(BuildContext context) {
    return new BackgroundGredient(
      child: new Stack(
        children: <Widget>[
          !isLoading ? pageToDisplay() : buildLoading(),
          isOverlay ? buildLoading() : new Container(),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return new Stack(
      children: [
        new Opacity(
          opacity: 0.5,
          child: const ModalBarrier(
            dismissible: false,
            color: kQuizBrown900,
          ),
        ),
        new Center(
          child: SpinKitThreeBounce(
            color: kQuizBackgroundWhite,
            size: 50.0,
          ),
        ),
      ],
    );
  }

  Widget pageToDisplay();
}
