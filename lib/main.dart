import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/app/my_app.dart';
import 'package:flutter_application_1/ui/widgets/app/my_app_model.dart';

// эта функция запускается уже 
// где-то внутри flutter и мы сделали ее асинхронной, 
// но по факту мы будем ждать пока загрузятся все методы которые требуются ожидания:
void main() async {
  // данный метод дает возможность
  // сделать функцию main() асинхронной, без нее будет ошибка. 

  // получается мы делаем работу до того, как все запускается, 
  // и путь решения только через эту функцию:
  WidgetsFlutterBinding.ensureInitialized();

  // создаем экземпляр модели:
  final model = MyAppModel();

  // вызываем через модель обновление флага авторизации, 
  // важно, что обновление флага мы производим 
  // до запуска приложения (т.е это проверка авторизации). 

  // тут важно понимать, что возможно нужно булет добавить loader screen, 
  // если действие занимаем много времени, но у нас тут небольшая задержка:
  await model.checkAuth();

  // передаем в MyApp модель и запускаем аппку:
  final myApp = MyApp(model: model);
  runApp(myApp);
}
