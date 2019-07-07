class UserInfo {
  bool isactive;
  String sId;
  String mobile;
  String password;
  String name;
  String email;
  int mhtId;
  String center;
  int bonus;
  int questionId;
  String profilePic;
  String updatedAt;
  String createdAt;
  int iV;
  String token;

  UserInfo(
      {this.isactive,
      this.sId,
      this.mobile,
      this.password,
      this.name,
      this.email,
      this.mhtId,
      this.center,
      this.bonus,
      this.questionId,
      this.updatedAt,
      this.createdAt,
      this.iV,
      this.token});

  UserInfo.fromJson(Map<String, dynamic> json) {
      isactive = json['isactive'];
      sId = json['_id'];
      mobile = json['mobile'];
      if(mobile == null)
        mobile = "";
      password = json['password'];
      name = json['name'];
      email = json['email'];
      if(email == null)
        email = "";
      mhtId = json['mht_id'];
      center = json['center'];
      bonus = json['bonus'];
      questionId = json['question_id'];
      profilePic = json['img_dropbox_url'];
      updatedAt = json['updatedAt'];
      createdAt = json['createdAt'];
      iV = json['__v'];
      token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isactive'] = this.isactive;
    data['_id'] = this.sId;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mht_id'] = this.mhtId;
    data['center'] = this.center;
    data['bonus'] = this.bonus;
    data['question_id'] = this.questionId;
    data['profilePic'] = this.profilePic;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['token'] = this.token;
    return data;
  }

}
