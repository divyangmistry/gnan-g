class LevelInfo {
  int levelIndex;
  String name;
  String levelType;

  LevelInfo(this.levelIndex,this.name);

  LevelInfo.fromJson(Map<String, dynamic> json) {
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
}