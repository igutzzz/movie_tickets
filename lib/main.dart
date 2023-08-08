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
  late Future<List<Movie>> movie;

  Future<List<Movie>> fetchMovies() async {
    final genreResponse = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=ed4c6ad6792ebf473ab3b183a8349992&language=pt-BR'));
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=ed4c6ad6792ebf473ab3b183a8349992&language=pt-BR'));

    if (response.statusCode == 200 && genreResponse.statusCode == 200) {
      var res = jsonDecode(response.body);
      var genreRes = jsonDecode(genreResponse.body);
      var genres = genreRes['genres'];
      List results = res['results'];
      List<Movie> movies = [];
      List<String> genresList = [];
      for (var item in results) {
        var movieGenres = item['genre_ids'];

        for (var genre in genres) {
          for (var movieGenre in movieGenres) {
            if (movieGenre == genre['id']) {
              genresList.add(genre['name']);
            }
          }
        }
        print(genresList);
        movies.add(Movie(
            adult: item['adult'],
            backdropPath: item['backdrop_path'],
            id: item['id'],
            title: item['title'],
            overview: item['overview'],
            posterPath: item['poster_path'],
            rating: item['vote_average'],
            genres: genresList));

        genresList = [];
      }

      return movies;
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
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: double.maxFinite,
            child: Column(
              children: [
                const Text("Encontre ingressos"),
                Expanded(
                  child: FutureBuilder<List<Movie>>(
                    future: movie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return MovieItem(
                                id: snapshot.data![index].id,
                                title: snapshot.data![index]?.title ?? '',
                                overview: snapshot.data![index].overview,
                                poster: snapshot.data?[index].posterPath ?? '',
                                rating: snapshot.data?[index].rating ?? 0,
                                genres: snapshot.data?[index].genres ?? []);
                          },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
