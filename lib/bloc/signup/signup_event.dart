part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class UserSignUp extends SignupEvent {
  final String userName;
  final String password;
  final String email;
  UserSignUp(
      {required this.email, required this.password, required this.userName});
}
