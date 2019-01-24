class AppResponse{
  int status;
  String message;
  Map<String,dynamic> data;

  AppResponse({
    this.status,this.message,this.data,
  });

  static AppResponse fromJson(Map<String,dynamic> json){
    return AppResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data,
  };
}