import 'package:flutter/material.dart';

class AnswerResponseDialog {


  static AlertDialog getAnswerResponseDialog({bool isSelectedAnsCorrect, Function doneButtonFn,}) {
      String msg;
        if (isSelectedAnsCorrect)
          msg = "You gave correct answer";
        else
          msg = "You gave wrong answer";
      return AlertDialog(
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              title: new Text(
                isSelectedAnsCorrect ? 'Success!' : 'LOL !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelectedAnsCorrect ? Colors.green : Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800),
              ),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(msg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300)),
                  SizedBox(height: 20.0),
                  new FlatButton.icon(
                      icon: isSelectedAnsCorrect
                          ? Icon(
                        Icons.done,
                        color: Colors.green,
                      )
                          : Icon(Icons.close, color: Colors.red),
                      label: new Text('Next',
                          style: TextStyle(
                              color: isSelectedAnsCorrect
                                  ? Colors.green
                                  : Colors.red)),
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.grey)),
                      onPressed: () {
                      }),
                ],
              ),
            );

  }
}