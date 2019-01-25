class SignUpSession{
  int otp;
  String msg;
  Map<String,dynamic> data;

  SignUpSession({
    this.otp,this.msg,this.data,
  });

  static SignUpSession fromJson(Map<String,dynamic> json){
    return SignUpSession(
      otp: json['otp'],
      msg: json['msg'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'otp': otp,
    'msg': msg,
    'data': data,
  };
}