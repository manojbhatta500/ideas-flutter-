import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:notes/bloc/login/login_bloc.dart';
import 'package:notes/models/login_model.dart';
import 'package:notes/utils/api.dart';
import 'package:notes/utils/token.dart';

class LoginRepository {
  Future<int> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(Apis.logIn);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userMail': email,
        'userPassword': password,
      }),
    );

    log('loginrepo mail :${email}');
    log('loginrepo password :${password}');

    if (response.statusCode == 200) {
      log('success request');
      log(response.body);
      Map<String, dynamic> decoded_msg = json.decode(response.body);
      final result = LoginModel.fromJson(decoded_msg);
      log('this is right');
      log(result.token!);
      Token.token = result.token!;

      // rn i am just saving this on temprory file and tommrow i will
      // store it in the shared prefrence or hive we will see

      log('this is Token class token ${Token.token}');

      return 1;
    } else {
      log('failed request');
      log(response.body);
      return 0;
    }
  }
}
