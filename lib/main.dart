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
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/week?api_key=ed4c6ad6792ebf473ab3b183a8349992&language=pt-BR'));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      List results = res['results'];
      List<Movie> movies = [];
      for (var item in results) {
        movies.add(Movie(
            adult: item['adult'],
            backdropPath: item['backdrop_path'],
            id: item['id'],
            title: item['title'],
            overview: item['overview'],
            posterPath: item['poster_path'],
            rating: item['vote_average']));
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
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 20/29
                            ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          itemBuilder: (context, index) {
                            return MovieItem(
                                id: snapshot.data![index].id,
                                title: snapshot.data![index]?.title ?? '',
                                overview: snapshot.data![index].overview,
                                poster: snapshot.data?[index].posterPath ?? '',
                                rating: snapshot.data?[index].rating ?? 0);
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
