class MovieCast {
  final int id;
  final String name;
  final String character;
  final String avatar;
  final int order;

  const MovieCast(
      {required this.id,
      required this.name,
      required this.character,
      required this.avatar,
      required this.order});

  factory MovieCast.fromJson(Map<String, dynamic> json) {
    return MovieCast(
        id: json['results']['credits']['cast']['id'],
        name: json['results']['credits']['cast']['name'],
        character: json['results']['credits']['cast']['character'],
        avatar: json['results']['credits']['cast']['avatar'],
        order: json['results']['credits']['cast']['order']
      );
  }
}
