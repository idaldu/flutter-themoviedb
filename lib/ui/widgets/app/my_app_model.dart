import 'package:flutter_application_1/domain/data_providers/session_data_provider.dart';

class MyAppModel {
  // создаем экземпляр провайдера сессии:
  final _sessionDataProvider = SessionDataProvider();

  // создаем флаг (приватный) по которому получаем статус авторизации:
  var _isAuth = false;

  // так как мы защитили флаг от изменений,
  // получаем его значение снаружи с помощью геттера:
  bool get isAuth => _isAuth;

  // дергаем данную функцию чтобы обновить значение флага:
  Future<void> checkAuth() async {

    // получаем sessionId из хранилища:
    final sessionId = await _sessionDataProvider.getSessionId();

    // если sessionId не равен null значит мы авторизованны: 
    _isAuth = sessionId != null;
  }
}
