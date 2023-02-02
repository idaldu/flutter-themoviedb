import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api_client/api_client.dart';
import 'package:flutter_application_1/domain/entity/movies.dart';
import 'package:flutter_application_1/domain/entity/popular_movies_response.dart';
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

  // текущая страница:
  late int _currentPage;

  late int _totalPage;

  var _isLoadingInProgres = false;

  String? searchQuery;

  // функция отображенния корректной даты:
  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    // устанавливаем значение текущей страницы:
    _currentPage = 0;

    _totalPage = 1;
    _movies.clear;
    _loadNextPage();
  }

  Future<PopularMovieResponse> _loadMovies(int nextPage, String locale) async {
    if (searchQuery == null) {
      return _apiClient.popularMovie(nextPage, _locale);
    } else {
      return await _apiClient.searchMovie(nextPage, locale, searchQuery!);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgres || _currentPage >= _totalPage) return;
    _isLoadingInProgres = true;

    // добавляем к значению страницы + 1,
    // и отображаем следующую страницу:
    final nextPage = _currentPage + 1;

    try {
      final moviesResponse = await _loadMovies(nextPage, _locale);
      _movies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;

      // важно при ошибке не уведомлять подписчиков,
      // так как произойдет бесконечная загрузка:
      notifyListeners();
    } catch (e) {
      _isLoadingInProgres = false;
    }
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }

  Future<void> searchMovie(String text) async {
    searchQuery = text.isEmpty ? text : null;
    await _resetList();
  }
}
