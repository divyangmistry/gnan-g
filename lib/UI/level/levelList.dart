import 'package:flutter/material.dart';
import '../../colors.dart';
import 'levelRow.dart';
import '../../model/quizlevel.dart';

class NewLevelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewLevelPageState();
}

class NewLevelPageState extends State<NewLevelPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kQuizSurfaceWhite,
      body: new SafeArea(
        child: Column(
          children: <Widget>[
            new SizedBox(height: 20),
            new Text(
              'LEVELS',
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            new SizedBox(height: 20),
            new LevelList(),
          ],
        ),
      ),
    );
  }
}

class LevelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(
        color: kQuizSurfaceWhite,
        child: new ListView.builder(
          itemExtent: 160.0,
          itemCount: DummyLevelList.levels.length,
          itemBuilder: (_, index) =>
              new LevelCardRow(DummyLevelList.levels[index]),
        ),
      ),
    );
  }
}