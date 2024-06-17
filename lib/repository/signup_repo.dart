import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:notes/models/login_model.dart';
import 'package:notes/utils/api.dart';
import 'package:notes/utils/token.dart';

class SignUpRepo {
  Future<int> signup(
      {required String email,
      required String password,
      required String userName}) async {
    final url = Uri.parse(Apis.signIn);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
          {'username': userName, 'userMail': email, 'userPassword': password}),
    );

    log('signin mail :${email}');
    log('signin password :${password}');
    log('signin username :${userName}');

    if (response.statusCode == 200) {
      log('success request');
      log(response.body);
      Map<String, dynamic> decoded_msg = json.decode(response.body);
      log(decoded_msg.toString());
      return 1;
    } else {
      log('failed request');
      log(response.body);
      return 0;
    }
  }
}
