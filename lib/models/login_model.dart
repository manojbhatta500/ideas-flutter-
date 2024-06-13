class LoginModel {
  String? message;
  String? email;
  String? token;

  LoginModel({this.message, this.email, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
