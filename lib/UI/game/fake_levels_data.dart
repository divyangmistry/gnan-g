import 'dart:ui';

import 'package:flutter/material.dart';

class NewCardView {
  String levelName;
  String levelScore;
  int levelNumber;
  bool selectedLevel;

  NewCardView(
      {this.levelName, this.levelScore, this.levelNumber, this.selectedLevel});

  NewCardView.fromJson(Map<String, dynamic> json) {
    levelName = json['levelName'];
    levelScore = json['levelScore'];
    levelNumber = json['levelNumber'];
    selectedLevel = json['selectedLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['levelName'] = this.levelName;
    data['levelScore'] = this.levelScore;
    data['levelNumber'] = this.levelNumber;
    data['selectedLevel'] = this.selectedLevel;
    return data;
  }
}

class LevelNameList {
  String levelName;
  Color levelColor;
  final List<NewCardView> levelCards;

  LevelNameList({this.levelCards, this.levelName, this.levelColor});

  factory LevelNameList.fromJson(List<dynamic> parsedJson) {
    List<NewCardView> levelCards = new List<NewCardView>();
    levelCards = parsedJson.map((i) => NewCardView.fromJson((i))).toList();

    return new LevelNameList(
      // levelNamelist: levelNamelist,
      levelCards: levelCards,
    );
  }
}

List<LevelNameList> allLevels = [
  LevelNameList(levelName: 'GNAN GANGA', levelColor: Colors.red, levelCards: [
    NewCardView(levelNumber: 01, levelScore: '200', selectedLevel: true),
    NewCardView(levelNumber: 02, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 03, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 04, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 05, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 06, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 07, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 08, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 09, levelScore: '200', selectedLevel: false),
    NewCardView(levelNumber: 10, levelScore: '200', selectedLevel: false),
  ]),
  LevelNameList(levelName: 'GNAN GOAL', levelColor: Colors.green, levelCards: [
    NewCardView(levelNumber: 01, levelScore: '300', selectedLevel: true),
    NewCardView(levelNumber: 02, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 03, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 04, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 05, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 06, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 07, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 08, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 09, levelScore: '300', selectedLevel: false),
    NewCardView(levelNumber: 10, levelScore: '300', selectedLevel: false),
  ]),
  LevelNameList(levelName: 'GNAN IS GOD', levelColor: Colors.blue, levelCards: [
    NewCardView(levelNumber: 01, levelScore: '400', selectedLevel: true),
    NewCardView(levelNumber: 02, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 03, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 04, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 05, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 06, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 07, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 08, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 09, levelScore: '400', selectedLevel: false),
    NewCardView(levelNumber: 10, levelScore: '400', selectedLevel: false),
  ]),
  LevelNameList(levelName: 'GNAN GHAR', levelColor: Colors.yellow, levelCards: [
    NewCardView(levelNumber: 01, levelScore: '500', selectedLevel: true),
    NewCardView(levelNumber: 02, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 03, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 04, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 05, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 06, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 07, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 08, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 09, levelScore: '500', selectedLevel: false),
    NewCardView(levelNumber: 10, levelScore: '500', selectedLevel: false),
  ]),
];
