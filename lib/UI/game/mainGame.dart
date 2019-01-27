import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/Service/apiservice.dart';
import 'package:kon_banega_mokshadhipati/UI/game/answer_response_dialog.dart';
import 'package:kon_banega_mokshadhipati/UI/widgets/base_state.dart';
import 'package:kon_banega_mokshadhipati/model/appresponse.dart';
import 'package:kon_banega_mokshadhipati/model/cacheData.dart';
import 'package:kon_banega_mokshadhipati/model/current_stat.dart';
import 'package:kon_banega_mokshadhipati/model/question.dart';
import 'package:kon_banega_mokshadhipati/utils/response_parser.dart';

import '../../colors.dart';
import '../../common.dart';
import '../../model/quizlevel.dart';

class MainGamePage extends StatefulWidget {
  final QuizLevel level;

  MainGamePage({this.level});

  @override
  State<StatefulWidget> createState() => new MainGamePageState();
}

class MainGamePageState extends BaseState<MainGamePage> {
  bool clickAns = false;
  List<bool> option = [false, false, false, false];
  int userLives = 3;
  bool trueAnswer = false;
  bool _changeTheme = false;
  bool _showLivesBanner = false;
  List<Question> questions;
  Question question;
  int currentQueIndex;
  bool isGivenCorrectAns = false;
  int correctAnsIndex = -1;
  int selectedAnsIndex = -1;
  ApiService _api = new ApiService();
  CurrentState currentState;
  @override
  void initState() {
    print(widget.level);
    super.initState();
    _loadData();
    // Flame.audio.play('music/bensound-epic.mp3');
  }
    _loadData() {
    isLoading = true;
    currentState = CacheData.userState.currentStat;
    _loadAllQuestions(widget.level.levelIndex);
  }

  _loadAllQuestions(int level) async {
    Response res = await _api.getQuestions(level: level, from: currentState.queSt);
    AppResponse appResponse =
        ResponseParser.parseResponse(context: context, res: res);
    if (appResponse.status == 200) {
      questions = Question.fromJsonArray(appResponse.data);
      print(questions);
      setState(() {
        question = questions.getRange(0, 1).first;
        currentQueIndex = 0;
        isLoading = false;
      });
    }
  }

  _displayAnswerResponseDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
            AnswerResponseDialog.getAnswerResponseDialog(isSelectedAnsCorrect: isGivenCorrectAns);
      },);
  }

  void onOKButtonClick(bool isCompletedLevel) {
    Navigator.pop(context);
    setState(() {
      if (!isCompletedLevel) {
        _reInit();
        _loadNextQuestion();
      } else {
        Navigator.pushReplacementNamed(context, '/level');
      }
    });
  }

  _loadNextQuestion() {
    if (currentQueIndex < questions.length - 1) {
      currentQueIndex++;
      question = questions.getRange(currentQueIndex, currentQueIndex + 1).first;
    } else {}
  }

  _reInit() {
    isGivenCorrectAns = false;
    correctAnsIndex = -1;
    selectedAnsIndex = -1;
  }

  void _onOptionSelect(index) {
    setState(() {
      correctAnsIndex = question.answerIndex;
      selectedAnsIndex = index;
      if (selectedAnsIndex == correctAnsIndex) {
        isGivenCorrectAns = true;
      } else {
        isGivenCorrectAns = false;
        if (userLives > 1) {
          userLives = userLives - 1;
        } else {}
          //return _gameOverDialogBox();
      }
      bool isCompletedLevel = false;
      if (currentQueIndex == questions.length - 1) isCompletedLevel = true;
      //_dialogBox(isGivenCorrectAns, isCompletedLevel);
    });
  }
  @override
  Widget pageToDisplay() {
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
                  ((question != null) ? question.question : ''),
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
        /*children: <Widget>[
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
        ]*/
        children: getOptionsWidget(),
      ),
    );
  }

  List<Widget> getOptionsWidget() {
    List<Widget> list = [];
    int i = 0;
    question.options.forEach((option) {
      if(option != null) {
        list.add(new SizedBox(height: 20));
        list.add(getOptionWidget(option.option, i++));
      }
    });
    return list;
  }
  Widget getOptionWidget(String text, index) {
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
}
