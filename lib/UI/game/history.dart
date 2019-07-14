import 'package:GnanG/UI/DailyBonusAnswer/ui/daily_bonus_answers.dart';
import 'package:GnanG/UI/DailyBonusAnswer/ui/winners.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Last Month Winners')),
              Tab(child: Text('Yesterday\'s Answer'),),
            ],
          ),
          title: Text('History'),
        ),
        body: TabBarView(
          children: [
            Winners(),
            DailyBonusAnswers(),
          ],
        ),
      ),
    );
  }
}
