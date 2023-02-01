import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api_client/api_client.dart';
import 'package:flutter_application_1/domain/data_providers/session_data_provider.dart';
import 'package:flutter_application_1/ui/navigation/main_navigation.dart';

class AuthWidgetModel extends ChangeNotifier {
  // создали экземпляр клиента с нашими запросами в сеть:
  final _apiClient = ApiClient();

  // создали приватный экземпляр провайдера сессии:
  final _sessionDataProvider = SessionDataProvider();

  // создали экземпляр контроллера для поля username:
  final userNameTextController = TextEditingController(text: 'alanddu');

  // создали экземпляр контроллера для поля password:
  final passwordTextController =
      TextEditingController(text: '62152bdhjricg@#\$\$');

  // флаг показывающий статус загрузки,
  // она приватная и чтобы ее получить используем геттер:
  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;

  // флаг можно начать авторизацию
  // и с помощью нее мы блокируем отправку запросов через кнопку логин:
  bool get canStartAuth => !_isAuthProgress;

  // переменная содержащая ошибку, она приватная чтобы ее неизменили,
  // через геттер получаем ее содержимое:
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // функция авторизации:
  Future<void> auth(BuildContext context) async {
    // создаем переменные с текстом из контроллеров:
    final login = userNameTextController.text;
    final password = passwordTextController.text;

    // записываем в _errorMessage ошибку
    // сли пользователь не заполнил какое-либо поле:
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }

    // если поля заполнены то идем дальше и ошибке присваеваем null,
    // а _isAuthProgress передаем true,
    // тем самым включаем загрузку на кнопке и оповещаем виджеты о изменении:
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();

    // создаем переменную sessionId:
    String? sessionId;

    // обрабатываем ошибки и если указан неверный логин или пароль
    // то присваеваем необходимое значение переменной _errorMessage:
    try {
      sessionId = await _apiClient.auth(
        userName: login,
        password: password,
      );
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Сервер недоступен, проверьте подключение к интернету';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Неправильный логин или пароль';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Произошла ошибка. Попробуйте еще раз';
          break;
      }
    } catch (error) {
      _errorMessage = 'Произошла ошибка. Попробуйте еще раз';
    }

    // передаем false и тем самым
    // убираем анимацию загрузки на кнопке:
    _isAuthProgress = false;

    // если ошибка не равна null, то уведомляем виджеты и выводим ее:
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    // если sessionId пустой то выводим неизвестную ошибку:
    if (sessionId == null) {
      _errorMessage = 'Неизвестная ошибка, повторите попытку';
      notifyListeners();
      return;
    }

    // если условия не выполнились, значит все нормально и мы записываем sessionId
    // в хранилище и переходим на главный экран:
    await _sessionDataProvider.setSessionId(sessionId);

    // тут мы воспользовались
    // абстрактным классом и передали нужный ключ, также мы убираем кнопку возврата на пред. экран  помощью
    // pushReplacementNamed:
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.main);
  }
}

// До этого мы прописывали провайдер в каждой модели, но теперь используем общий 
// который создается из универсального класса и ему передается нужный тип:

// class AuthWidgetModelProvider extends InheritedNotifier {
//   final AuthWidgetModel model;

//   const AuthWidgetModelProvider(
//       {super.key, required Widget child, required this.model})
//       : super(
//           child: child,
//           notifier: model,
//         );

//   static AuthWidgetModelProvider? watch(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<AuthWidgetModelProvider>();
//   }

//   static AuthWidgetModelProvider? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<AuthWidgetModelProvider>()
//         ?.widget;
//     return widget is AuthWidgetModelProvider ? widget : null;
//   }
// }
