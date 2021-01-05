import 'package:flutter/material.dart';
import 'package:movies_project/Models/genre.dart';
import 'package:movies_project/Widget/genres_movie_items.dart';

class GenreMovieDetails extends StatelessWidget {
  final List<Genres> genres;
  GenreMovieDetails(this.genres);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genres',
            style: Theme.of(context).textTheme.headline5,
          ),
          Wrap(
            children: genres.map((genre) {
              return GenresMovieItems(genre.name);
            }).toList(),
          )
        ],
      ),
    );
  }
}
