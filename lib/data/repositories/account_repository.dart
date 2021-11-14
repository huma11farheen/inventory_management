import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginResult { successfull, failed }

class AccountRepository {
  /// Try to fetch current logged in user, throws NoSuchUserException if user not exists.
  const AccountRepository();

  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<void> setToken({String token}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString('token', token);
  }

  Future<void> registerUser(
      {@required String userName,
      @required String email,
      @required String contactNumber,
      @required String password,
      @required String confirmPassword,
      @required String recoveryQuestion,
      @required String recoveryAnswer,
      @required String userType}) async {
    final response =
        await post(Uri.parse("http://65.1.236.26:8000/register/"), body: {
      'username': userName,
      'phone_no': contactNumber,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'recovery_question': recoveryQuestion,
      'recovery_answer': recoveryAnswer,
      'user_type': userType
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      final token = json["token"] as String;

      await setToken(token: token);
    }
  }

  Future<LoginResult> signIn({
    @required String username,
    @required String password,
  }) async {
    final response =
        await post(Uri.parse("http://65.1.236.26:8000/login/"), body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      final token = json["token"] as String;

      await setToken(token: token);
      return LoginResult.successfull;
    } else {
      return LoginResult.failed;
    }
  }
}

class NotAuthenticatedException implements Exception {
  @override
  String toString() => '🤓 This account is not Authenticated.';
}

class NoSuchUserException implements Exception {
  final String userId;

  NoSuchUserException(this.userId);

  @override
  String toString() => "No such user: ID = $userId";
}
