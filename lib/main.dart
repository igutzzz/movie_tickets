import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_tickets/components/movie_item.dart';
import 'package:movie_tickets/data/movie_class.dart';
import 'package:movie_tickets/data/movie_details.dart';

void main() {
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Movie> movie;

  Future<Movie> fetchMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/all/week?api_key=ed4c6ad6792ebf473ab3b183a8349992&language=pt-BR'));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return Movie.fromJson(res['results'][0]);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    movie = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Movie>(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MovieItem(
                id: snapshot.data!.id,
                title: snapshot.data!.title,
                overview: snapshot.data!.overview,
                poster: snapshot.data?.posterPath ?? "",
                rating: snapshot.data!.rating,
              );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
            return const Text(
              'Erro ao acessar os dados',
              textDirection: TextDirection.ltr,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
