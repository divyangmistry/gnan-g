import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
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
  bool _changeTheme = false;
  bool _showLivesBanner = false;

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
          child: new Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            // overflow: Overflow.clip,
            children: <Widget>[
              // new ListView(
              //   shrinkWrap: true,
              //   padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              //   children: <Widget>[
              //     // SizedBox(height: 50),
              //   ],
              // ),
              // Container(
              //   alignment: Alignment(0, -1),
              //   child: titleBar(),
              // ),
              Container(
                alignment: Alignment(-1, -1),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: kQuizSurfaceWhite,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                alignment: Alignment(0, -0.95),
                child: Text(
                  widget.level.name.toUpperCase(),
                  textScaleFactor: 1.2,
                  style: TextStyle(color: kQuizSurfaceWhite),
                ),
              ),
              Container(
                alignment: Alignment(0.90, -0.95),
                child: Text('120 \$',
                    style: TextStyle(color: kQuizBackgroundWhite),
                    textScaleFactor: 1.2),
              ),
              Container(
                alignment: Alignment(0, -0.30),
                child: Text(
                  'When do you want to here your Rundown ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kQuizBackgroundWhite,
                  ),
                  textScaleFactor: 1.6,
                ),
              ),
              new Container(
                alignment: Alignment(0, 0.95),
                padding: EdgeInsets.all(50),
                child: questionUi(),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment(0, 0.95),
                child: _showLivesBanner
                    ? Card(
                        elevation: 20.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.zero,
                            topLeft: Radius.circular(60.0),
                            topRight: Radius.circular(60.0),
                            bottomLeft: Radius.circular(60.0),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 200.0,
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                onTap: () => debugPrint(
                                    'Cutting off the money for 1 life !'),
                                title: Text('Earn 1 life => '),
                                trailing: Icon(Icons.person),
                              ),
                              ListTile(
                                onTap: () => debugPrint(
                                    'Cutting off the money for 2 life !'),
                                title: Text('Earn 2 life => '),
                                trailing: Icon(Icons.group),
                              ),
                            ],
                          ),
                          // color: Colors.blue,
                        ),
                      )
                    : null,
              )
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
                    Text(
                      'Lives : ',
                      style: TextStyle(color: kQuizBackgroundWhite),
                    ),
                    GestureDetector(
                      onLongPress: () => Tooltip(
                            message: 'Earn LIVES !',
                          ),
                      onTap: () {
                        setState(() {
                          _showLivesBanner
                              ? _showLivesBanner = false
                              : _showLivesBanner = true;
                          print('$_showLivesBanner');
                        });
                      },
                      child: Container(
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
                    )
                  ],
                ),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          trueAnswer
              ? Flame.audio.play('music/party_horn-Mike_Koenig-76599891.mp3')
              : Flame.audio.play('music/Pac man dies.mp3');
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
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 60.0,
                ),
              ),
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
          _bottomDrawerItems(),
        ],
      ),
    );
  }

  Widget _bottomDrawerItems() {
    return SwitchListTile(
      // selected: true,
      onChanged: (bool value) {
        setState(() {
          !value ?? true;
        });
      },
      value: true,
      title: Text('Change Theme :'),
    );
  }

  Widget questionUi() {
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      // alignment: Alignment(0, 0.75),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
          ),
        ],
      ),
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

  // Widget titleBar() {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //       new IconButton(
  //         icon: Icon(
  //           Icons.close,
  //           color: kQuizSurfaceWhite,
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //       new Expanded(
  //         child: new Container(),
  //       ),
  //       new Text(
  //         widget.level.name.toUpperCase(),
  //         textScaleFactor: 1.2,
  //         style: TextStyle(color: kQuizSurfaceWhite),
  //       ),
  //       new Expanded(
  //         child: new Container(),
  //       ),
  //       Container(
  //         child: Text('120 \$',
  //             style: TextStyle(color: kQuizBackgroundWhite),
  //             textScaleFactor: 1.2),
  //       )
  //     ],
  //   );
  // }
}
