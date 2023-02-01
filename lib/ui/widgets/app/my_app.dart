import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/navigation/main_navigation.dart';
import 'package:flutter_application_1/ui/theme/colors.dart';
import 'package:flutter_application_1/ui/widgets/app/my_app_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;

  const MyApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();

    return MaterialApp(
      title: 'flutter themoviedb',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en'),
      ],
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
