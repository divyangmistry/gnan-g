import 'package:flutter/material.dart';
import '../../model/quizlevel.dart';
import '../../colors.dart';

class MainGamePage extends StatefulWidget {
  final QuizLevel level;

  MainGamePage({this.level});

  @override
  State<StatefulWidget> createState() => new MainGamePageState();
}

class MainGamePageState extends State<MainGamePage> {
  bool clickAns = false;
  List option = [false, false, false, false];

  @override
  void initState() {
    print(widget.level);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
            colors: [
              kQuizMain100,
              kQuizMain300,
            ],
          ),
        ),
        child: SafeArea(
          child: new ListView(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            children: <Widget>[
              titleBar(),
              SizedBox(height: 50),
              new Padding(
                padding: EdgeInsets.all(50),
                child: questionUi(),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: option.contains(true)
          ? new FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.check,
                // color: kQuizBrown900,
                size: 30,
              ),
              backgroundColor: Colors.green,
            )
          : new Container(),
    );
  }

  Widget questionUi() {
    return new Column(
      children: <Widget>[
        new Text(
          'When do you want to here your Rundown ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kQuizBackgroundWhite,
          ),
          textScaleFactor: 1.6,
        ),
        new SizedBox(height: 30),
        options('Option 1', 0),
        new SizedBox(height: 20),
        options('Option 2', 1),
        new SizedBox(height: 20),
        options('Option 3', 2),
        new SizedBox(height: 20),
        options('Option 4', 3),
      ],
    );
  }

  Widget options(String text, index) {
    return new SizedBox(
      width: double.infinity,
      child: new MaterialButton(
        elevation: 5,
        onPressed: () {
          setState(() {
            option = [false, false, false, false];
            option[index] = !option[index];
          });
        },
        height: 50,
        child: Row(
          children: <Widget>[
            option[index]
                ? new Container(
                    width: 0,
                    child: Icon(
                      Icons.check_circle,
                      size: 25,
                      color: kQuizBackgroundWhite,
                    ),
                  )
                : new Container(),
            Expanded(
              child: Text(
                text,
                textScaleFactor: 1.1,
                style: TextStyle(
                  color: option[index] ? kQuizBackgroundWhite : kQuizMain400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        color: option[index] ? kQuizMain400 : kQuizBackgroundWhite,
      ),
    );
  }

  Widget titleBar() {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          // color: kQuizSurfaceWhite,
        ),
        new Expanded(
          child: new Container(),
        ),
        new Text(
          widget.level.name.toUpperCase(),
          textScaleFactor: 1.2,
          // style: TextStyle(color: kQuizSurfaceWhite),
        ),
        new Expanded(
          child: new Container(),
        ),
        new IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
          // color: kQuizSurfaceWhite,
        ),
      ],
    );
  }
}
