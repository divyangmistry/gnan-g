class AppSetting {
  String appversion;

  AppSetting({this.appversion});

  AppSetting.fromJson(Map<String, dynamic> json) {
    appversion = json['appversion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appversion'] = this.appversion;
    return data;
  }
}