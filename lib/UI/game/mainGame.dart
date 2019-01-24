import 'package:flame/flame.dart';
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
  List<bool> option = [false, false, false, false];
  int userLives = 3;
  bool trueAnswer = false;

  @override
  void initState() {
    print(widget.level);
    super.initState();
    // Flame.audio.loop('music/bensound-epic.mp3');
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
              // SizedBox(height: 50),
              new Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(50),
                child: questionUi(),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: kBackgroundGrediant1,
          elevation: 10.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: kQuizBackgroundWhite,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        builder: (BuildContext context) => _bottomDrawer(),
                        context: context);
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Lives : ',
                        style: TextStyle(color: kQuizBackgroundWhite)),
                    new Container(
                      height: 25,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: userLives,
                        itemBuilder: (BuildContext context, int index) {
                          return Icon(
                            Icons.account_circle,
                            color: kQuizBackgroundWhite,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          // trueAnswer
          //     ? Flame.audio.play('music/party_horn-Mike_Koenig-76599891.mp3')
          //     : Flame.audio.play('music/Pac man dies.mp3');
        },
        backgroundColor: kQuizMain400,
        icon: Icon(Icons.done),
        label: Text('SUBMIT'),
      ),
    );
  }

  Widget _bottomDrawer() {
    return Drawer(
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: CircleAvatar(
              child: Image.asset('images/face.png'),
              maxRadius: 50.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'Root_Node',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'hobo'),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ListTile(
            title: Text('Option 01'),
          ),
        ],
      ),
    );
  }

  Widget questionUi() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // verticalDirection: VerticalDirection.down,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
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
        Container(
          child: options('Option 4', 3),
          alignment: Alignment.bottomCenter,
        )
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
            option[3] == true ? trueAnswer = true : trueAnswer = false;
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new IconButton(
          icon: Icon(
            Icons.close,
            color: kQuizSurfaceWhite,
          ),
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
        Container(
          child: Text('120 \$',
              style: TextStyle(color: kQuizBackgroundWhite),
              textScaleFactor: 1.2),
        )
      ],
    );
  }
}
