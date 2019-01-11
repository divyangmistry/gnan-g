class QuizLevel {
  int levelIndex;
  String name;
  String levelType;

  QuizLevel(this.levelIndex,this.name);

  QuizLevel.fromJson(Map<String, dynamic> json) {
    levelIndex = int.parse(json['level_index']);
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