import 'dart:async';

import 'package:flutter_login/authentication/authentication_event.dart';
import 'package:flutter_login/authentication/authentication_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUnauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if(event is AppStartedEvent) {

      final bool hasToken = await userRepository.hasToken();

      if(hasToken) {
        yield AuthenticationAuthenticatedState();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if(event is LoggedInEvent) {
      yield AuthenticationLoadingState();
      await userRepository.persistToken();
      yield AuthenticationAuthenticatedState();
    }

    if(event is LoggedOutEvent) {
      yield AuthenticationLoadingState();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
