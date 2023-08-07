// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'movie_cast.dart';

class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String poster;
  final String tagline;
  final List<MovieCast>? cast;

  const MovieDetails(
      {required this.id,
      required this.title,
      required this.overview,
      required this.poster,
      required this.tagline,
      this.cast});

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    final List<dynamic> credits = json['credits'] != null ? json['credits']['cast'] : [];
    final List<MovieCast> cast = [];

    if (credits != []) {
      credits.forEach((item) {
        cast.add(MovieCast.fromJson(item));
      });
    }

    return MovieDetails(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        poster: json['poster_path'] ?? '',
        tagline: json['tagline'],
        cast: cast.isEmpty ? null : cast,  
      );
  }
}
