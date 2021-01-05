import 'package:flutter/material.dart';

class GenresMovieItems extends StatelessWidget {
  final String genreItem;
  GenresMovieItems(this.genreItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
      padding: EdgeInsets.all(8),
      child: Text(
        genreItem,
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white),
      ),
    );
  }
}
