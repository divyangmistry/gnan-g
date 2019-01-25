class QuizLevel {
  int levelIndex;
  String name;
  String levelType;

  QuizLevel(this.levelIndex,this.name);

  QuizLevel.fromJson(Map<String, dynamic> json) {
    levelIndex = json['level_index'];
    name = json['name'];
    levelType = json['level_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level_index'] = this.levelIndex;
    data['name'] = this.name;
    data['level_type'] = this.levelType;
    return data;
  }

  @override
  String toString() {
    return 'QuizLevel{levelIndex: $levelIndex, name: $name, levelType: $levelType}';
  }


}


class DummyLevelList {

  static final List<QuizLevel> levels = [
    QuizLevel(1,'Level 1'),
    QuizLevel(2,'Level 2'),
    QuizLevel(3,'Level 3'),
    QuizLevel(4,'Level 4'),
    QuizLevel(5,'Level 5'),
    QuizLevel(6,'Level 6'),
    QuizLevel(7,'Level 7'),
    QuizLevel(8,'Level 8'),
    QuizLevel(9,'Level 9'),
    QuizLevel(10,'Level 10'),
    QuizLevel(11,'Level 11'),
  ];

}