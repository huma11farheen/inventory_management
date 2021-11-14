import 'package:flutter/material.dart';
import 'package:inventory_management/data/repositories/account_repository.dart';

class LoginPageController {
  final AccountRepository accountRepository;

  LoginPageController({@required this.accountRepository});

  void login({
    @required String userName,
    @required String email,
    @required String contactNumber,
    @required String password,
    @required String confirmPassword,
    @required String recoveryQuestion,
    @required String recoveryAnswer,
    @required String userType,
  }) {
    accountRepository.registerUser(
        email: email,
        password: password,
        contactNumber: contactNumber,
        confirmPassword: confirmPassword,
        userType: userType,
        recoveryAnswer: recoveryAnswer,
        userName: userName,
        recoveryQuestion: recoveryQuestion);
  }
}
