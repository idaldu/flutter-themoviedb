import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends StatefulWidget {
  // передаем модель для сохранения ее в виджете:
  final Model model;

  // флаг который служит для контроля
  // закрытия модели (если модель используется из вне):
  final bool isManagingModel;

  // передача виджета в который далее будет передаваться модель:
  final Widget child;

  const NotifierProvider({
    Key? key,
    required this.model,

    // изначальное значение true,
    // так как мы в основном управляем закрытием модели:
    this.isManagingModel = true,
    required this.child,
  }) : super(key: key);

  @override
  State<NotifierProvider> createState() => _NotifierProviderState<Model>();

  // статичный метод, подписываемся на изменения в модели:
  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()
        ?.model;
  }

  // статичный метод, не подписываемся на изменения в модели:
  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            _InheritedNotifierProvider<Model>>()
        ?.widget;
    return widget is _InheritedNotifierProvider<Model> ? widget.model : null;
  }
}

class _NotifierProviderState<Model extends ChangeNotifier>
    extends State<NotifierProvider<Model>> {
  
  // производим изначальную резервацию, 
  // т.к инициализацию будем проводить в initState(), 
  // тут мы передаем модель в стейт: 
  late final Model _model;

  @override
  void initState() {
    super.initState();
    
    // проводим инициализацию, и передаем модель в стейт: 
    _model = widget.model;
  }

  @override
  Widget build(BuildContext context) {

    // возвращаем провайдер с виджетом и моделью: 
    return _InheritedNotifierProvider(
      model: _model,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (widget.isManagingModel) {

      // закрываем модель: 
      _model.dispose();
    }
    super.dispose();
  }
}

class _InheritedNotifierProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;

  const _InheritedNotifierProvider(
      {super.key, required Widget child, required this.model})
      : super(
          child: child,
          notifier: model,
        );
}

class Provider<Model> extends InheritedWidget {
  final Model model;

  const Provider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          child: child,
        );

  static Model? watch<Model>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<Provider<Model>>()
        ?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return model != oldWidget.model;
  }
}