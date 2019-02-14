import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication_bloc.dart';
import 'package:flutter_login/login/login.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  const LoginPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    _loginBloc = LoginBloc(
      userRepository: widget.userRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: LoginForm(
            loginBloc: _loginBloc, authenticationBloc: _authenticationBloc),
      );

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
