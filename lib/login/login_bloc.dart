import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_login/authentication/authentication_bloc.dart';
import 'package:flutter_login/authentication/authentication_event.dart';
import 'package:flutter_login/login/login_events.dart';
import 'package:flutter_login/login/login_state.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginLoadingState();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedInEvent(token: token));
        yield LoginInitialState();
      } catch (error) {
        yield LoginFailureState(error: error.toString());
      }
    }
  }
}
