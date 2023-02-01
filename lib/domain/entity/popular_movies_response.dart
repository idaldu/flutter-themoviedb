import 'package:flutter_application_1/domain/entity/movies.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_movies_response.g.dart';

// тут используется explicitToJson так как у нас есть внутреняя генерация:
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMovieResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;

  PopularMovieResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieResponseToJson(this);
}
