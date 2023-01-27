import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// тут мы храним ключ по которому
// создаем и получаем значение из secureStorage:
abstract class _Keys {
  static const sessionId = 'session_id';
}

// в данном классе мы реализуем провайдер,
// через который мы можем записать значение в secureStorage и получить его:
class SessionDataProvider {
  // получили экземпляр хранилища:
  static const _secureStorage = FlutterSecureStorage();

  // метод получения sessionId из хранилища,
  // для этого используем ключ:
  Future<String?> getSessionId() =>
      _secureStorage.read(key: _Keys.sessionId);

  // если передаем значение то записываем его, а если передаем
  // null то удаляем ключ:
  Future<void> setSessionId(String? value) {
    if (value != null) {
      return _secureStorage.write(key: _Keys.sessionId, value: value);
    } else {
      return _secureStorage.delete(key: _Keys.sessionId);
    }
  }
}
