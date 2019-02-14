import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication_bloc.dart';
import 'package:flutter_login/login/login_bloc.dart';
import 'package:flutter_login/login/login_events.dart';
import 'package:flutter_login/login/login_state.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  const LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{

  final _usernameController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocBuilder(
    bloc: widget.loginBloc,
    builder: (BuildContext context, LoginState loginState) {

      if (loginState is LoginFailureState) {

        _onWidgetDidBuild(() {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${loginState.error}'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }

      return Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'username'),
              controller: _usernameController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'password'),
              controller: _pwdController,
              obscureText: true,
            ),
            RaisedButton(
              onPressed:
              loginState is! LoginLoadingState ? _onLoginButtonPressed : null,
              child: Text('Login'),
            ),
            Container(
              child:
              loginState is LoginLoadingState ? CircularProgressIndicator() : null,
            ),
          ],
        ),
      );
    },
  );

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    widget.loginBloc.dispatch(LoginButtonPressedEvent(
      username: _usernameController.text,
      password: _pwdController.text,
    ));
  }
}
