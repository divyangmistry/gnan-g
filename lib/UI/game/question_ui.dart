import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/UI/game/mcq.dart';
import 'package:GnanG/UI/game/pikachar.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/model/boolean_wrapper.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/question.dart';
import 'package:GnanG/model/validateQuestion.dart';
import 'package:GnanG/utils/app_utils.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// Not Used , Keeped for backup purpose
class QuestionUI extends StatefulWidget {
  Question question;
  int level;
  Function onAnswerGiven;
  Function validateAnswer;
  List<int> hiddenOptionIndex = [];
  bool isOverlay;
  QuestionUI(
      this.question, this.level, this.onAnswerGiven, this.hiddenOptionIndex, this.isOverlay);

  @override
  QuestionUIState createState() {
    return new QuestionUIState();
  }
}

class QuestionUIState extends State<QuestionUI> {
  Question question;
  bool isGivenCorrectAns = false;
  ApiService _api = new ApiService();
  @override
  Widget build(BuildContext context) {
    question = widget.question;
    return Expanded(
      child: question.questionType == "MCQ"
          ? new MCQ(question, validateAnswer, widget.hiddenOptionIndex)
          : new Pikachar(question.question, question.jumbledata, question.pikacharAnswer, validateAnswer),
    );
  }

  void onAnswerStatusDialogOK() {
    Navigator.pop(context);
    widget.onAnswerGiven(isGivenCorrectAns);
  }

  void validateAnswer({String answer}) async {
    /*setState(() {
      widget.isOverlay = true;
    });
    Response res = await _api.validateAnswer(
      questionId: widget.question.questionId,
      mhtId: CacheData.userInfo.mhtId,
      answer: answer,
      level: widget.level,
    );
    setState(() {
      widget.isOverlay = false;
    });
    AppResponse appResponse =
        ResponseParser.parseResponse(context: context, res: res);
    if (appResponse.status == WSConstant.SUCCESS_CODE) {
      ValidateQuestion validateQuestion =
          ValidateQuestion.fromJson(appResponse.data);
      setState(() {
        isGivenCorrectAns = true;
        validateQuestion.updateSessionScore();
      });
      if (validateQuestion.answerStatus) {
        CommonFunction.alertDialog(
          context: context,
          msg: 'Your answer is correct !!',
          type: 'success',
          barrierDismissible: false,
          doneButtonFn: onAnswerStatusDialogOK,
        );
        AppUtils.appSound(() {
          Flame.audio.play('music/party_horn-Mike_Koenig-76599891.mp3');
        });
      } else {
        isGivenCorrectAns = false;
        CommonFunction.alertDialog(
          context: context,
          msg: 'Your answer is wrong !!',
          barrierDismissible: false,
          doneButtonFn: onAnswerStatusDialogOK,
        );
        AppUtils.appSound(() {
          Flame.audio.play('music/Pac man dies.mp3');
        });
      }
    }*/
  }
}
