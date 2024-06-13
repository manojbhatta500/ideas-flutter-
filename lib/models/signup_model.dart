// 200 status code model right

// 400 statuscode  wrong

class SignUpModel {
  String? message;
  String? token;

  SignUpModel({this.message, this.token});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}
