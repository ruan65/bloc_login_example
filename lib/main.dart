import 'package:flutter/material.dart';
import 'package:flutter_login/splash/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo login',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashPage(),
    );
  }
}
