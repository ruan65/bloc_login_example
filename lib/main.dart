import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication_bloc.dart';
import 'package:flutter_login/authentication/authentication_event.dart';
import 'package:flutter_login/authentication/authentication_state.dart';
import 'package:flutter_login/common/LoadingIndicator.dart';
import 'package:flutter_login/home/home_page.dart';
import 'package:flutter_login/login/login_page.dart';
import 'package:flutter_login/splash/splash_page.dart';
import 'package:user_repository/user_repository.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  AuthenticationBloc authenticationBloc;

  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.dispatch(AppStartedEvent());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        bloc: authenticationBloc,
        child: MaterialApp(
          home: BlocBuilder(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if(state is AuthenticationUninitializedState) {
                return SplashPage();
              }
              if(state is AuthenticationAuthenticatedState) {
                return HomePage();
              }
              if(state is AuthenticationUnauthenticated) {
                return LoginPage(userRepository: userRepository);
              }
              if(state is AuthenticationLoadingState) {
                return LoadingIndicator();
              }
            },
          ),
        ),
      );
}
