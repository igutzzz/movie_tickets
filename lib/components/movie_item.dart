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
        width: 185,
        padding: const EdgeInsets.all(10),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://image.tmdb.org/t/p/original/$poster',
                height: 250,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold
                  ),),
                  Row(
                    children: [
                      const Icon(Icons.star_half_outlined),
                      Text(rating.toStringAsFixed(2), style: GoogleFonts.inter(),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
