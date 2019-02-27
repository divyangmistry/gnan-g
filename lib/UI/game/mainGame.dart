import 'dart:math';

import 'package:GnanG/UI/game/mcq.dart';
import 'package:GnanG/UI/game/question_ui.dart';
import 'package:GnanG/UI/game/title_bar.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/UI/widgets/base_state.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/current_stat.dart';
import 'package:GnanG/model/question.dart';
import 'package:GnanG/model/user_score_state.dart';
import 'package:GnanG/model/validateQuestion.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pikachar.dart';

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
  bool isLoading = false;
  bool isOverlay = false;
  List<int> hiddenOptionIndex = [];
  int userLives = CacheData.userState.lives;
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
    // Flame.audio.play('music/bensound-epic.mp3', volume: 0.5);
  }

  _loadData() {
    isLoading = true;
    currentState = CacheData.userState.currentState;
    print('currentState ::::::::: ');
    print(currentState);
    _loadAllQuestions(widget.level.levelIndex);
  }

  _loadAllQuestions(int level) async {
    Response res =
        await _api.getQuestions(level: level, from: currentState.questionSt);
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

  void onOKButtonClick(bool isCompletedLevel) {
    Navigator.pop(context);
    setState(() {
      if (!isCompletedLevel) {
        _loadNextQuestion();
      } else {
        Navigator.pushReplacementNamed(context, '/level');
      }
    });
  }

  _loadNextQuestion() {
    if (currentQueIndex < questions.length - 1) {
      setState(() {
        hiddenOptionIndex = [];
        currentQueIndex++;
        question =
            questions.getRange(currentQueIndex, currentQueIndex + 1).first;
      });
    }
  }

  void onAnswerGiven(bool isGivenCorrectAns) {
    try {
      setState(() {

      });
      if (isGivenCorrectAns) {
        if (currentQueIndex == questions.length - 1) {
          CommonFunction.alertDialog(
              context: context,
              msg: 'Level ' + question.level.toString() + ' completed !! ',
              barrierDismissible: false,
              type: 'success',
              doneButtonFn: () async {
                setState(() {
                  isOverlay = true;
                  isLoading = true;
                });
                bool result = await CommonFunction.loadUserState(
                    context, CacheData.userInfo.mhtId);
                if (result) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  setState(() {
                    isLoading = false;
                    isOverlay = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                    isOverlay = false;
                  });
                }
              });
        } else {
          _loadNextQuestion();
        }
      } else {
        if (userLives == 1) {
          CommonFunction.alertDialog(
            context: context,
            msg: 'You have only 1 Life remaining. Now you can access hint.',
            barrierDismissible: false,
          );
        }
        if (userLives == 0) {
          CommonFunction.alertDialog(
              context: context,
              msg: 'Game-over',
              barrierDismissible: false,
              doneButtonFn: () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
        }
      }
    } catch (err) {
      print('CATCH VALIDATE QUESTION :: ');
      print(err);
      CommonFunction.displayErrorDialog(
        context: context,
        msg: err.toString(),
      );
    }
  }

  @override
  Widget pageToDisplay() {
    return new Scaffold(
      body: CustomLoading(
        isLoading: isLoading,
        child: new BackgroundGredient(
          child: SafeArea(
              child: new Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: new Column(
                    children: <Widget>[
                      GameTitleBar(widget.level.name),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                      ),
                      QuestionUI(
                          question, CacheData.userState.currentState.level, onAnswerGiven, hiddenOptionIndex),
                    ],
                  ))),
        ),
      ),
      bottomNavigationBar: _buildbottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: userLives <= 1
          ? FloatingActionButton.extended(
              icon: Icon(Icons.help_outline),
              label: Text('Get Hint'),
              onPressed: _getHint,
            )
          : null,
    );
  }

  Widget _buildbottomNavigationBar() {
    return BottomAppBar(
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
    );
  }

  void _getHint() async {
    // CommonFunction.loadUserState(context, CacheData.userInfo.mhtId);
    try {
      Response res = await _api.hintTaken(
          questionId: question.questionId, mhtId: CacheData.userInfo.mhtId);
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        UserScoreState userScoreState =
            UserScoreState.fromJson(appResponse.data);
        setState(() {
          userScoreState.updateSessionScore();
        });
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user_info', res.body);
        print('FROM HINT :: ');
        print(res.body);
        CommonFunction.alertDialog(
            context: context,
            msg: question.reference,
            type: 'success',
            doneButtonText: 'Hooray!',
            title: 'Here is your hint ...',
            barrierDismissible: false);
      }
    } catch (err) {
      print('CATCH IN HINT :: ');
      print(err);
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
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
            // trailing: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     Text(
            //       2.toString(),
            //       textScaleFactor: 2,
            //     ),
            //     Text(
            //       getOrdinalOfNumber(2),
            //       style: TextStyle(height: 2),
            //     ),
            //   ],
            // ),
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
              lifeline(Icons.call, 'Phone a Friend', _phoneAFriend),
              CustomVerticalDivider(
                height: 100,
              ),
              lifeline(Icons.star_half, '50 - 50', _fiftyFifty),
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

  _phoneAFriend() {
    print('Phone a Friend');
  }

  _fiftyFifty() {
    var rng = new Random();
    while (hiddenOptionIndex.length < 2) {
      int temp = rng.nextInt(3);
      if (temp != question.answerIndex &&
          hiddenOptionIndex.indexOf(temp) == -1) {
        setState(() {
          hiddenOptionIndex.add(temp);
        });
      }
    }
  }

  Widget lifeline(IconData icon, String lifelineName, Function fn) {
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
            onPressed: fn,
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
}
