import 'dart:io' show Platform;

class AppSetting {
  String appversion;
  String ios_appversion;

  String get version => Platform.isIOS ? ios_appversion : appversion;

  AppSetting({this.appversion, this.ios_appversion});

  AppSetting.fromJson(Map<String, dynamic> json) {
    appversion = json['appversion'];
    ios_appversion = json['ios_appversion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appversion'] = this.appversion;
    data['ios_appversion'] = this.ios_appversion;
    return data;
  }
}