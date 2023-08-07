class Movie {
  final bool adult;
  final String backdropPath;
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double rating;

  const Movie(
      {required this.adult,
      required this.backdropPath,
      required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.rating,});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        id: json['id'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        rating: json['vote_average'],
        title: json['title'],
      );
  }
}
