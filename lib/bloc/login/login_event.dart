part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class Userlogin extends LoginEvent {
  String email;
  String password;
  Userlogin({required this.email, required this.password});
}
