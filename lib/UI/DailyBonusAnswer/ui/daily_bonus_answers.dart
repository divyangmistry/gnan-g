import 'package:GnanG/UI/DailyBonusAnswer/bloc/daily_bonus_answer_bloc.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/model/daily_bonus_answer.dart';
import 'package:flutter/material.dart';

class DailyBonusAnswers extends StatefulWidget {
  final DateTime date;

  DailyBonusAnswers(this.date);
  @override
  _DailyBonusAnswersState createState() => _DailyBonusAnswersState();
}

class _DailyBonusAnswersState extends State<DailyBonusAnswers> {
  @override
  void initState() {
    bloc.getDailyBonusAnswer(widget.date);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainUI() {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(3),
            child: Card(
              child: ListTile(
                title: Text(
                  'Question From API Is come here with ?',
                  style: TextStyle(
                    fontFamily: 'Gujarati',
                    color: kQuizMain400,
                  ),
                ),
                leading: CircleAvatar(
                  child: Text('${index+1}'),
                ),
                subtitle: Text(
                  'Answers',
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
                AsyncSnapshot<DailyBonusAnswer> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Text('Data Loaded'),
                );
              }
              if (snapshot.hasError) {
                return Container(
                  child: Text(
                    'Error to Load Answers !! \n\n${snapshot.error}',
                    style: TextStyle(
                      color: kQuizErrorRed,
                    ),
                  ),
                );
              }
              return mainUI();
              // return Center(
              //   child: CircularProgressIndicator(),
              // );
            }),
      ),
    );
  }
}
