import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/repository/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Userlogin>(_userlogin);
  }
  LoginRepository manager = LoginRepository();

  FutureOr<void> _userlogin(Userlogin event, Emitter<LoginState> emit) async {
    emit(Loginloading());
    final repoResponse =
        await manager.login(email: event.email, password: event.password);

    if (repoResponse == 1) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailed());
    }
  }
}
