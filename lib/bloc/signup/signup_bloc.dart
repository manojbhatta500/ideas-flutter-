import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/repository/signup_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<UserSignUp>(_userSignup);
  }

  SignUpRepo manager = SignUpRepo();

  FutureOr<void> _userSignup(
      UserSignUp event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    final repoResponse = await manager.signup(
        email: event.email, password: event.password, userName: event.userName);
    if (repoResponse == 1) {
      emit(SignupSuccess());
    } else {
      emit(SignupFailed());
    }
  }
}
