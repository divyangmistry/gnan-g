import 'dart:io' show Platform;

class AppSetting {
  String appversion;
  String ios_appversion;
  int score_per_lives;
  String get version => Platform.isIOS ? ios_appversion : appversion;

  AppSetting({this.appversion, this.ios_appversion});

  AppSetting.fromJson(Map<String, dynamic> json) {
    if(json['appversion'] != null)
      appversion = json['appversion'];
    if(json['ios_appversion'] != null)
      ios_appversion = json['ios_appversion'];
    if(json['score_per_lives'] != null)
      score_per_lives = json['score_per_lives'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appversion'] = this.appversion;
    data['ios_appversion'] = this.ios_appversion;
    data['score_per_lives'] = this.score_per_lives;
    return data;
  }
}