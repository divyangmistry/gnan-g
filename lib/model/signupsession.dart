class SignUpSession {
  int otp;
  String msg;
  UserData userData;

  SignUpSession({this.otp, this.msg, this.userData});

  SignUpSession.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    msg = json['msg'];
    userData = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['msg'] = this.msg;
    if (this.userData != null) {
      data['data'] = this.userData.toJson();
    }
    return data;
  }
}

class UserData {
  String sId;
  String mobile;
  String name;
  String email;
  int mhtId;
  String center;
  String password;

  UserData(
      {this.sId,
        this.mobile,
        this.name,
        this.email,
        this.mhtId,
        this.center,
        this.password});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobile = json['mobile'];
    name = json['name'];
    email = json['email'];
    mhtId = json['mht_id'];
    center = json['center'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mht_id'] = this.mhtId;
    data['center'] = this.center;
    data['password'] = this.password;
    return data;
  }
}