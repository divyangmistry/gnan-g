import 'package:SheelQuotient/model/user_state.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:SheelQuotient/Service/apiservice.dart';
import 'package:SheelQuotient/UI/widgets/base_state.dart';
import 'package:SheelQuotient/constans/wsconstants.dart';
import 'package:SheelQuotient/model/appresponse.dart';
import 'package:SheelQuotient/model/cacheData.dart';
import 'package:SheelQuotient/model/current_stat.dart';
import 'package:SheelQuotient/model/question.dart';
import 'package:SheelQuotient/model/user_score_state.dart';
import 'package:SheelQuotient/model/userinfo.dart';
import 'package:SheelQuotient/model/validateQuestion.dart';
import 'package:SheelQuotient/utils/response_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLoading = false;
  List<bool> option = [false, false, false, false];
  int userLives = CacheData.userState.lives;
  bool trueAnswer = false;
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
        _reInit();
        _loadNextQuestion();
      } else {
        Navigator.pushReplacementNamed(context, '/level');
      }
    });
  }

  _loadNextQuestion() {
    Navigator.pop(context);
    if (currentQueIndex < questions.length - 1) {
      setState(() {
        currentQueIndex++;
        question =
            questions.getRange(currentQueIndex, currentQueIndex + 1).first;
      });
    } else {}
  }

  _reInit() {
    isGivenCorrectAns = false;
    correctAnsIndex = -1;
    selectedAnsIndex = -1;
  }

  void _onOptionSelect({int index, String answer}) async {
    try {
      Response res = await _api.validateAnswer(
        questionId: question.questionId,
        mhtId: CacheData.userInfo.mhtId,
        answer: answer,
        level: CacheData.userState.currentState.level,
      );
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        option = [false, false, false, false];
        ValidateQuestion validateQuestion =
            ValidateQuestion.fromJson(appResponse.data);
        if (validateQuestion.answerStatus) {
          print('***************');
          print(validateQuestion);
          setState(() {
            userLives = validateQuestion.lives;
            validateQuestion.updateSessionScore();
          });
          isGivenCorrectAns = true;
          Flame.audio.play('music/party_horn-Mike_Koenig-76599891.mp3');
          if (currentQueIndex == questions.length - 1) {
            CommonFunction.alertDialog(
                context: context,
                msg: 'Level ' + question.level.toString() + ' completed !! ',
                barrierDismissible: false,
                type: 'success',
                doneButtonFn: () {
                  _loadUserState(CacheData.userInfo.mhtId);
                });
          } else {
            CommonFunction.alertDialog(
              context: context,
              msg: 'Your answer is correct !!',
              type: 'success',
              barrierDismissible: false,
              doneButtonFn: _loadNextQuestion,
            );
          }
        } else {
          CommonFunction.alertDialog(
            context: context,
            msg: 'Your answer is wrong !!',
            barrierDismissible: false,
          );
          Flame.audio.play('music/Pac man dies.mp3');
          isGivenCorrectAns = false;
          setState(() {
            userLives = validateQuestion.lives;
            validateQuestion.updateSessionScore();
          });
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
                  Navigator.pop(context);
                });
          }
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

  _loadUserState(int mhtId) async {
    try {
      Response res = await _api.getUserState(mhtId: mhtId);
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        print('IN LOGIN ::: userstateStr :::');
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userState', res.body);
        UserState userState = UserState.fromJson(appResponse.data['results']);
        CacheData.userState = userState;
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (err) {
      print('CATCH 2 :: ');
      print(err);
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
  }

  @override
  Widget pageToDisplay() {
    return new Scaffold(
      body: CustomLoading(
        isLoading: isLoading,
        child: new BackgroundGredient(
          child: SafeArea(
            child: new ListView(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              children: <Widget>[
                titleBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 16,
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
                  padding: EdgeInsets.fromLTRB(50, 30, 50, 50),
                  child: questionUi(),
                ),
              ],
            ),
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

  void _getHint() async {
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
            context: context,
            point: CacheData.userState.totalscore.toString(),
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
              lifeline(Icons.call, 'Phone a Friend'),
              CustomVerticalDivider(
                height: 100,
              ),
              lifeline(Icons.star_half, '50 - 50'),
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
        children: getOptionsWidget(),
      ),
    );
  }

  List<Widget> getOptionsWidget() {
    List<Widget> list = [];
    int i = 0;
    question.options.forEach((option) {
      if (option != null) {
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
            _onOptionSelect(index: index, answer: text);
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
}
