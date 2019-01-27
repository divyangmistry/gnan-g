import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
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
    // Flame.audio.play('music/bensound-epic.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new BackgroundGredient(
        child: SafeArea(
          child: new ListView(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            children: <Widget>[
              titleBar(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Container(
                alignment: Alignment(0, -0.30),
                child: Text(
                  'When do you want to here your Rundown ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kQuizBackgroundWhite,
                    height: 1.5,
                  ),
                  textScaleFactor: 1.6,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(50),
                child: questionUi(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kBackgroundGrediant1,
        elevation: 10.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
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
                    Container(
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
          ),
        ),
      ),
    );
  }

  Widget titleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: kQuizSurfaceWhite,
            ),
            onPressed: () {
              // Flame.audio.clear('music/bensound-epic.mp3');
              // Flame.audio.clearCache();
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          child: Text(
            widget.level.name.toUpperCase(),
            textScaleFactor: 1.2,
            style: TextStyle(color: kQuizSurfaceWhite),
          ),
        ),
        Container(
          child: CommonFunction.pointsUI(
            point: CacheData.userInfo.totalscore.toString(),
          ),
        ),
      ],
    );
  }

  Widget _bottomDrawer() {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: kQuizMain400,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kQuizMain50,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/face.jpg'),
                    ),
                  ),
                ),
              ),
              maxRadius: 30.0,
            ),
            title: Text(
              CacheData.userInfo.name,
              textScaleFactor: 1.3,
            ),
            subtitle: Text(
              CacheData.userInfo.email + '\n' + CacheData.userInfo.mobile,
              style: TextStyle(color: kQuizMain50, height: 1.3),
            ),
            dense: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  2.toString(),
                  textScaleFactor: 2,
                ),
                Text(
                  getOrdinalOfNumber(2),
                  style: TextStyle(height: 2),
                ),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: kQuizMain50,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: new Center(
              child: Text(
                'Life-Lines',
                textScaleFactor: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              lifeline(Icons.call, 'Phone a Friend'),
              CustomVerticalDivider(
                height: 100,
              ),
              lifeline(Icons.star_half, '50 - 50'),
              CustomVerticalDivider(
                height: 100,
              ),
              lifeline(Icons.group, 'Audiance poll'),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: kQuizMain50,
          ),
          SizedBox(
            height: 20.0,
          ),
          new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(width: 20),
              Text(
                'How to play ?',
                style: TextStyle(
                  color: kQuizMain50,
                ),
              ),
              Text(
                'Terms and conditions',
                style: TextStyle(
                  color: kQuizMain50,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget lifeline(IconData icon, String lifelineName) {
    return Expanded(
      child: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.blue[100],
            padding: EdgeInsets.all(15),
            shape: CircleBorder(),
            child: Icon(
              icon,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(height: 20),
          Text(
            lifelineName,
            textScaleFactor: 1.1,
          ),
        ],
      ),
    );
  }

  String getOrdinalOfNumber(int n) {
    int j = n % 10;
    int k = n % 100;
    if (j == 1 && k != 11) {
      return "st";
    }
    if (j == 2 && k != 12) {
      return "nd";
    }
    if (j == 3 && k != 13) {
      return "rd";
    }
    return "th";
  }

  Widget questionUi() {
    return Container(
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
            trueAnswer
                ? Flame.audio.play('music/party_horn-Mike_Koenig-76599891.mp3')
                : Flame.audio.play('music/Pac man dies.mp3');
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
}
