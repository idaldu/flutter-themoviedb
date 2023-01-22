import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/auth/auth_widget.dart';
import 'package:flutter_application_1/ui/widgets/main/main_screen_widget.dart';

abstract class MainNavigationRoutsNames {
  static const auth = 'auth';
  static const main = 'main_screen';
}

class MainNavigation {
  final initialRoute = MainNavigationRoutsNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutsNames.auth: (context) => const AuthWidget(),
    MainNavigationRoutsNames.main: (context) => const MainScreenWidget(),
  };
}
