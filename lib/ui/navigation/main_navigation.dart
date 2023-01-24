import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/auth/auth_widget.dart';
import 'package:flutter_application_1/ui/widgets/auth/auth_widget_model.dart';
import 'package:flutter_application_1/ui/widgets/main/main_screen_widget.dart';
import 'package:flutter_application_1/ui/widgets/movie_details/movie_datails_widget.dart';

abstract class MainNavigationRoutsNames {
  static const auth = 'auth';
  static const main = 'main_screen';
  static const movieDetails = '/main_screen/movie_details';
}

class MainNavigation {
  final initialRoute = MainNavigationRoutsNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutsNames.auth: (context) => AuthWidgetModelProvider(
        model: AuthWidgetModel(), child: const AuthWidget()),
    MainNavigationRoutsNames.main: (context) => const MainScreenWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutsNames.movieDetails:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => MovieDatailsWidget(id: id),
        );
      default:
        const widget = Text('Route Error!!!');
        return MaterialPageRoute(
          builder: (context) => widget,
        );
    }
  }
}
