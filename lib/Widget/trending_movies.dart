import 'package:flutter/material.dart';
import 'package:movies_project/Widget/movies_list.dart';

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
              left: 10,
            ),
            child: Text(
              "Trending Movies",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          MoviesList.trending(),
        ],
      ),
    );
  }
}
