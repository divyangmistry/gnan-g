import 'package:flutter/material.dart';
import 'package:SheelQuotient/colors.dart';
import 'package:SheelQuotient/common.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kQuizSurfaceWhite,
      body: new BackgroundGredient(
        child: CustomLoading(
          child: !isLoading ? pageToDisplay() : new Container(),
          isLoading: isLoading,
        ),
      ),
    );
  }

  Widget pageToDisplay();
}
