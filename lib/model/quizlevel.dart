class QuizLevel {
  int levelIndex;
  String name;
  String levelType;
  int totalPoints;
  String imgUrl;
  String description;

  QuizLevel(this.levelIndex,this.name);

  QuizLevel.fromJson(Map<String, dynamic> json) {
    levelIndex = json['level_index'];
    name = json['name'];
    levelType = json['level_type'];
    totalPoints = json['totalscores'];
    imgUrl = json['imagepath'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level_index'] = this.levelIndex;
    data['name'] = this.name;
    data['level_type'] = this.levelType;
    data['totalscores'] = this.totalPoints;
    data['imagepath'] = this.imgUrl;
    data['description'] = this.description;
    return data;
  }

  @override
  String toString() {
    return 'QuizLevel{levelIndex: $levelIndex, name: $name, levelType: $levelType}';
  }


}