import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieItem extends StatelessWidget {
  final int id;
  final String title;
  final String overview;
  final String poster;
  final double rating;
  final List<String> genres;

  const MovieItem({
    super.key,
    required this.id,
    required this.title,
    required this.overview,
    required this.poster,
    required this.rating,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(
                'https://image.tmdb.org/t/p/original/$poster',
                height: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 350,
                  child: Text(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    title,
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      for (var item in genres) Text(
                      genres.indexOf(item) == genres.indexOf(genres.last) ? item : "$item / ",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0
                      ),
                    )],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
