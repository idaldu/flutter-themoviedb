import 'package:flutter/material.dart';
import 'package:flutter_application_1/library/widgets/inherited/notifier_provider.dart';
import 'package:flutter_application_1/ui/widgets/auth/auth_widget.dart';
import 'package:flutter_application_1/ui/widgets/auth/auth_widget_model.dart';
import 'package:flutter_application_1/ui/widgets/main/main_screen_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_details_widget_model.dart';

// тут прописаны маршруты, с помощью
// данного класса мы меняем их в одном месте:
abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const main = '/';
  static const movieDetails = '/movie_details';
}

// тут прописана вся логика навигации:
class MainNavigation {
  // в зависимости от того, авторизованы
  // мы или нет возвращаем разные экраны:
  String initialRoute(bool isAuth) =>
      isAuth ? MainNavigationRouteNames.main : MainNavigationRouteNames.auth;

  // тут прописаны основные роуты в
  // которых мы не передаем никакие аргументы:
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) => NotifierProvider(
          model: AuthWidgetModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteNames.main: (context) => const MainScreenWidget(),
  };

  // данный класс генерит экраны в зависимости
  // от переданного ключа мы генерим экран и передаем туда аргументы:
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:

        // вот тут мы могли бы просто вытащить сразу с аргумента
        // id, но мы делаем проверку, там если аргументов попало много мы подстраховываемся
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            model: MovieDetailsWidgetModel(movieId: movieId),
            child: const MovieDetailsWidget(),
          ),
        );

      // дефолтный экран, если не подошели кейсы в свитче,
      //в основном тут всегда прописан экран ошибки:
      default:
        const widget = Text('Route Error!!!');
        return MaterialPageRoute(
          builder: (context) => widget,
        );
    }
  }
}
