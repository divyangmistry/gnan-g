class UserInfo {
  String lives;
  String isactive;
  String id;
  String mobile;
  String password;
  String name;
  String email;
  String mht_id;
  String center;
  String bonus;
  String question_id;
  String totalscore;
  String updatedAt;
  String createdAt;
  String v;

  UserInfo({
    this.lives,this.isactive,this.id,this.mobile,this.password,this.name,this.email,this.mht_id,this.center,this.bonus,this.question_id,this.totalscore,this.updatedAt,this.createdAt,this.v,
  });

  static UserInfo fromJson(Map<String,dynamic> json){
    return UserInfo(
      lives: json['lives'],
      isactive: json['isactive'],
      id: json['_id'],
      mobile: json['mobile'],
      password: json['password'],
      name: json['name'],
      email: json['email'],
      mht_id: json['mht_id'],
      center: json['center'],
      bonus: json['bonus'],
      question_id: json['question_id'],
      totalscore: json['totalscore'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
    'lives': lives,
    'isactive': isactive,
    '_id': id,
    'mobile': mobile,
    'password': password,
    'name': name,
    'email': email,
    'mht_id': mht_id,
    'center': center,
    'bonus': bonus,
    'question_id': question_id,
    'totalscore': totalscore,
    'updatedAt': updatedAt,
    'createdAt': createdAt,
    '__v': v,
  };
}