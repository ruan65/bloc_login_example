import 'dart:async';

import 'package:meta/meta.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<void> persistToken() async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 2));
    return false;
  }
}