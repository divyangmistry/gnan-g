import 'package:GnanG/UI/DailyBonusAnswer/bloc/daily_bonus_answer_bloc.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/model/daily_bonus_answer.dart';
import 'package:GnanG/model/question.dart';
import 'package:flutter/material.dart';

class DailyBonusAnswers extends StatefulWidget {
  @override
  _DailyBonusAnswersState createState() => _DailyBonusAnswersState();
}

class _DailyBonusAnswersState extends State<DailyBonusAnswers> {
  @override
  void initState() {
    bloc.getDailyBonusAnswer();
    super.initState();
  }

  // @override
  // void dispose() {
  //   bloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Widget mainUI(List<Question> data) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(3),
            child: Card(
              child: ListTile(
                title: Text(
                  '${data[index].question}',
                  style: TextStyle(
                    fontFamily: 'Gujarati',
                    color: kQuizMain400,
                  ),
                ),
                leading: CircleAvatar(
                  child: Text('${index+1}'),
                ),
                subtitle: Text(
                  'Answer: ${data[index].answer[0].answer}',
                  style: TextStyle(
                    fontFamily: 'Gujarati',
                    color: kQuizMain500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundGrediant1,
      appBar: AppBar(
        title: Text('Yesterday Answers'),
        backgroundColor: kQuizMain400,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: bloc.dailyBonusAnswer,
            builder: (BuildContext context,
                AsyncSnapshot<List<Question>> snapshot) {
              if (snapshot.hasData) {
                print('************');
                print(snapshot.data);
                return mainUI(snapshot.data);
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                    'There was no daily bonus question asked yesterday !!\n\nHave a good day !!\n\nJSCA',
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kQuizErrorRed,
                    ),
                  ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
