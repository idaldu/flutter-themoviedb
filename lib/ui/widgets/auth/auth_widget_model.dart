import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api_client/api_client.dart';
import 'package:flutter_application_1/domain/data_providers/session_data_provider.dart';

class AuthWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _isAuthProgress = false;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = userNameTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
        userName: login,
        password: password,
      );
    } catch (error) {
      _errorMessage = 'Неправильный логин или пароль';
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMessage = 'Неизвестная ошибка, повторите попытку';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    Navigator.of(context).pushNamed('main_screen');
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
