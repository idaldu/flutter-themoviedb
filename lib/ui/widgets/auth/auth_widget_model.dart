import 'package:flutter/material.dart';

class AuthWidgetModel extends ChangeNotifier {
  String? userName;
  String? password;
  String errorText = '';

  AuthWidgetModel({
    this.userName,
    this.password,
  });

  void auth(BuildContext context) {
    if (userName == '' || password == '') return;
    if (userName == 'admin' && password == 'admin') {
      errorText = '';
      Navigator.of(context).pushNamed('main_screen');
      notifyListeners();
    } else {
      errorText = 'Не верный логин или пароль';
      notifyListeners();
    }
  }

  void resetPassword(BuildContext context) {
    print('reset password');
  }
}

class AuthWidgetModelProvider extends InheritedNotifier {
  final AuthWidgetModel model;

  const AuthWidgetModelProvider(
      {super.key, required Widget child, required this.model})
      : super(
          child: child,
          notifier: model,
        );

  static AuthWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthWidgetModelProvider>();
  }

  static AuthWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<AuthWidgetModelProvider>()
        ?.widget;
    return widget is AuthWidgetModelProvider ? widget : null;
  }
}
