import 'package:flutter/material.dart';
import 'package:inventory_management/domain/app_navigator.dart';
import 'package:inventory_management/ui/home_page/home_page.dart';

import '../../data/repositories/account_repository.dart';

enum Validation { empty, valid, noAccount }

class ViewModel {
  final Validation username;
  final Validation password;
  final bool noAccount;

  ViewModel({this.noAccount, @required this.username, @required this.password});
}

class SignInController extends ValueNotifier<ViewModel> {
  final AccountRepository accountRepository;
  final AppNavigator appNavigator;

  SignInController(this.accountRepository, this.appNavigator)
      : super(
          ViewModel(username: Validation.valid, password: Validation.valid),
        );
  void setUserName(String username) {
    if (username.isEmpty) {
      value = ViewModel(username: Validation.empty, password: value.password);
    } else {
      value = ViewModel(username: Validation.valid, password: value.password);
    }
  }

  void setPassword(String password) {
    if (password.isEmpty) {
      value = ViewModel(username: value.username, password: Validation.empty);
    } else {
      value = ViewModel(username: value.username, password: Validation.valid);
    }
  }

  Future<void> signIn({
    @required String username,
    @required String password,
  }) async {
    final result =
        await accountRepository.signIn(username: username, password: password);
    switch (result) {
      case LoginResult.successfull:
        appNavigator.pushAndRemoveAllPage(HomePage.routeName);
        break;
      case LoginResult.failed:
        value = ViewModel(
            username: value.username,
            password: value.password,
            noAccount: true);
        break;
    }
  }
}
