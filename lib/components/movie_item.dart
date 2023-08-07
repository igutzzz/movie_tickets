import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieItem extends StatelessWidget {
  final int id;
  final String title;
  final String overview;
  final String poster;
  final double rating;

  const MovieItem(
      {super.key,
      required this.id,
      required this.title,
      required this.overview,
      required this.poster,
      required this.rating,});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[900],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                'https://image.tmdb.org/t/p/original/$poster',
                height: 250,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 5, right: 5),
              child:Text(title, style: GoogleFonts.inter(
                fontWeight: FontWeight.bold
              ),)
              ),
          ],
        ),
      ),
    );
  }
}
