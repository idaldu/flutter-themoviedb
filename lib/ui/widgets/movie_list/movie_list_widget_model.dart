import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/movies.dart';
import 'package:flutter_application_1/resources/resources.dart';

class MovieListWidgetModel extends ChangeNotifier {
  List filteredMovies = <Movie>[];
  final movies = [
    Movie(
      id: 1,
      imageName: AppImages.moviePlacholder,
      title: 'Смертельная битва',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 2,
      imageName: AppImages.moviePlacholder,
      title: 'Прибытие',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 3,
      imageName: AppImages.moviePlacholder,
      title: 'Назад в будущее 1',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 4,
      imageName: AppImages.moviePlacholder,
      title: 'Назад в будущее 2',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 5,
      imageName: AppImages.moviePlacholder,
      title: 'Назад в будущее 3',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 6,
      imageName: AppImages.moviePlacholder,
      title: 'Первому игроку приготовится',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 7,
      imageName: AppImages.moviePlacholder,
      title: 'Пиксели',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 8,
      imageName: AppImages.moviePlacholder,
      title: 'Человек паук',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 9,
      imageName: AppImages.moviePlacholder,
      title: 'Лига справедливости',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 10,
      imageName: AppImages.moviePlacholder,
      title: 'Человек из стали',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 11,
      imageName: AppImages.moviePlacholder,
      title: 'Мстители',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 12,
      imageName: AppImages.moviePlacholder,
      title: 'Форд против феррари',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 13,
      imageName: AppImages.moviePlacholder,
      title: 'Джентельмены',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 14,
      imageName: AppImages.moviePlacholder,
      title: 'Тихие зори',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 15,
      imageName: AppImages.moviePlacholder,
      title: 'В бой идут одни старики',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
    Movie(
      id: 16,
      imageName: AppImages.moviePlacholder,
      title: 'Дюна',
      time: 'April  7, 2021',
      description: 'Washed-up MMA fighter Cole Young, unaware of his heritage',
    ),
  ];

  MovieListWidgetModel() {
    setup();
  }

  void searchMovies(searchText) {
    final query = searchText;
    if (query.isNotEmpty) {
      filteredMovies = movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      notifyListeners();
    } else {
      filteredMovies = movies;
      notifyListeners();
    }
  }

  void setup() {
    filteredMovies = movies;
  }
}

class MovieListWidgetModelProvider extends InheritedNotifier {
  final MovieListWidgetModel model;

  const MovieListWidgetModelProvider(
      {super.key, required Widget child, required this.model})
      : super(
          child: child,
          notifier: model,
        );

  static MovieListWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MovieListWidgetModelProvider>();
  }

  static MovieListWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<MovieListWidgetModelProvider>()
        ?.widget;
    return widget is MovieListWidgetModelProvider ? widget : null;
  }
}
