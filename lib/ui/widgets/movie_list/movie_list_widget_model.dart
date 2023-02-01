import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api_client/api_client.dart';
import 'package:flutter_application_1/domain/entity/movies.dart';
import 'package:flutter_application_1/ui/navigation/main_navigation.dart';
import 'package:intl/intl.dart';

class MovieListWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];

  // неизменяемый лист:
  List<Movie> get movies => List.unmodifiable(_movies);

  // создали экземпляр даты, чтобы снизить нагрузку,
  // т.к пришлось бы создавать каждый раз новый экземпляр, если бы делали это в верстке:
  late DateFormat _dateFormat;
  String _locale = '';

  // функция отображенния корректной даты:
  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear;
    _loadMovie();
  }

  Future<void> _loadMovie() async {
    final moviesResponse = await _apiClient.popularMovie(1, _locale);
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  // void searchMovies(searchText) {
  //   final query = searchText;
  //   if (query.isNotEmpty) {
  //     filteredMovies = movies.where((Movie movie) {
  //       return movie.title.toLowerCase().contains(query.toLowerCase());
  //     }).toList();
  //     notifyListeners();
  //   } else {
  //     filteredMovies = movies;
  //     notifyListeners();
  //   }
  // }
}
