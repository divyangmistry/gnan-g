import 'package:flutter/material.dart';
import 'colors.dart';

// For override color for Form input
class AccentColorOverride extends StatelessWidget {
  final Color color;
  final Widget child;
  AccentColorOverride({Key key, @required this.color, @required this.child})
      : assert(color != null),
        assert(child != null);

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
  BackgroundGredient({@required this.child}) : assert(child != null);

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

// All common functions
class CommonFunction {
  // mhtId Validation
  String mhtIdValidation(value) {
    if (value.isEmpty) {
      return 'Mht ID is required';
    } else if (value.length != 6) {
      return 'Mht ID must have 6 digit';
    }
    return null;
  }

  // password Validation
  String passwordValidation(value) {
    Pattern pattern =
        r'(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Passwords must contain at least six characters';
    } else if (!regex.hasMatch(value)) {
      return 'Passwords must contain uppercase, lowercase letters and numbers';
    }
    return null;
  }

  // otp Validation
  String otpValidation(String value) {
    if (value.isEmpty) {
      return 'OTP is required';
    } else if (value.length != 6) {
      return 'OTP must have 6 digit';
    }
    return null;
  }

  // mobile Validation
  String mobileValidation(value) {
    if (value.isEmpty) {
      return 'Mobile no. is required';
    } else if (value.length != 10) {
      return 'Enter Valid Mobile no.';
    }
    return null;
  }

  // common Alert dialog
  alertDialog({
    @required BuildContext context,
    String title,
    @required String msg,
    bool showDoneButton = true,
    IconData doneButtonIcon = Icons.done,
    String doneButtonText = 'Try Again',
    @required Function doneButtonFn,
    bool showCancel = false,
    IconData cancelButtonIcon = Icons.close,
    String cancelButtonText = 'Cancel',
    @required Function cancelButtonFn,
    bool barrierDismissible = true,
    AlertDialog Function() builder,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return AlertDialog(
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          title:
              title != null ? Text(title, textAlign: TextAlign.center) : null,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                msg,
                style: TextStyle(color: Colors.blueGrey),
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  showCancel
                      ? FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                cancelButtonIcon,
                                size: 22.0,
                                color: Colors.blue[900],
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                cancelButtonText,
                                style: TextStyle(color: Colors.blue[900]),
                              )
                            ],
                          ),
                          onPressed: cancelButtonFn != null
                              ? cancelButtonFn
                              : () {
                                  Navigator.pop(context);
                                  return false;
                                },
                        )
                      : new Container(width: 0, height: 0),
                  showCancel
                      ? SizedBox(
                          width: 10.0,
                        )
                      : new Container(width: 0, height: 0),
                  showDoneButton
                      ? FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.blue[900],
                          child: Row(
                            children: <Widget>[
                              Icon(
                                doneButtonIcon,
                                size: 22.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                doneButtonText,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onPressed: doneButtonFn != null
                              ? doneButtonFn
                              : () {
                                  Navigator.pop(context);
                                },
                        )
                      : new Container(width: 0, height: 0),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
