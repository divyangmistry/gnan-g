import 'package:flutter/material.dart';
import '../../model/quizlevel.dart';
import '../../colors.dart';
import '../../common.dart';

class MainGamePage extends StatefulWidget {
  final QuizLevel level;

  MainGamePage({this.level});

  @override
  State<StatefulWidget> createState() => new MainGamePageState();
}

class MainGamePageState extends State<MainGamePage> {
  bool clickAns = false;
  List option = [false, false, false, false];
  int userLives = 3;

  @override
  void initState() {
    print(widget.level);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new BackgroundGredient(
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
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Text('Points : ', style: TextStyle(color: kQuizMain50)),
              Text('120\$',
                  style: TextStyle(color: kQuizBrown900), textScaleFactor: 1.2),
              SizedBox(width: 20),
              Text('Lives : ', style: TextStyle(color: kQuizMain50)),
              new Container(
                height: 25,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: userLives,
                  itemBuilder: (BuildContext context, int index) {
                    return Icon(Icons.account_circle);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: new FloatingActionButton.extended(
        label: Text('Get Hint'),
        icon: Icon(Icons.help_outline),
        onPressed: () {},
        backgroundColor: kQuizMain400,
      ),
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
          style: TextStyle(color: kQuizSurfaceWhite),
        ),
        new Expanded(
          child: new Container(),
        ),
        new IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }
}
