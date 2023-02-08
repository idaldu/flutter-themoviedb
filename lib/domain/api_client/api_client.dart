import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/domain/entity/movie_details.dart';
import 'package:flutter_application_1/domain/entity/popular_movies_response.dart';

// типы ошибок, также более правильно
// булет создать класс под каждую ошибку и можно
// неиспользовать enum тогда, а просто прописывать класс:
enum ApiClientExceptionType { network, auth, other }

// создали свой класс для исключений,
// лучше имплементировать от Exception так как ошибки обрабатываются в ней:
class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '1126a37c55c5fa8e146a7149dccf55d6';

  static String imageUrl(String path) => _imageUrl + path;

  Future<String> auth({
    required String userName,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      userName: userName,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);

    // обрабатываем исключения:
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();

      // для универсального метода у нас тут dynamic,
      // так как json может быть разным:
      final json = (await response.jsonDecode());

      // тут мы самостоятельно создаем ошибку которую потом отловим,
      // данная ошибка связана с ключем, а мы его сами зашили:
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      // тут отлавливаем ошибки сокета, т.е ошибка с сетью:
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      // тут отлавливаем ошибки связанные с ключем api_key,
      // и передаем ее с помощью rethrow выше:
      rethrow;
    } catch (_) {
      // в остальных ошибках просто используем исключение другие:
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> bodyParameters, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(
        path,
        urlParameters,
      );
      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final json = await response.jsonDecode();

      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      // тут отлавливаем ошибки сокета, т.е ошибка с сетью:
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      // тут отлавливаем ошибки связанные с ключем api_key,
      // и передаем ее с помощью rethrow выше:
      rethrow;
    } catch (_) {
      // в остальных ошибках просто используем исключение другие:
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get(
      '/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/search/movie',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  Future<MovieDetails> movieDetails(
    String locale,
    int movieId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/$movieId',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<String> _validateUser({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final parameters = <String, dynamic>{
      'username': userName,
      'password': password,
      'request_token': requestToken,
    };
    final result = _post(
      '/authentication/token/validate_with_login',
      parser,
      parameters,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final result = _post(
      '/authentication/session/new',
      parser,
      parameters,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }
}

// расширяем класс и добавляем метод:
extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}

/*
status_code:
30 - неверный логин или пароль
7 - неверный api_key
33 - неверный токен
*/
