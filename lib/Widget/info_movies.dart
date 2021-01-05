import 'package:flutter/material.dart';
import 'package:movies_project/Widget/info_movie_Items.dart';

class InfoMovies extends StatelessWidget {
  final String budget, runtime, releasedate;
  InfoMovies(this.budget, this.runtime, this.releasedate);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoMovieItems('Budget', budget),
          InfoMovieItems('Runtime', runtime),
          InfoMovieItems('Release Date', releasedate),
        ],
      ),
    );
  }
}
