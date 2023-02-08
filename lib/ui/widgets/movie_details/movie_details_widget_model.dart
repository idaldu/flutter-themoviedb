// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:flutter_application_1/domain/api_client/api_client.dart';
import 'package:flutter_application_1/domain/entity/movie_details.dart';
import 'package:intl/intl.dart';

class MovieDetailsWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  String _locale = '';
  late DateFormat _dateFormat;
  
  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsWidgetModel({
    required this.movieId,
  });

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(_locale, movieId);
    notifyListeners();
  }
}
