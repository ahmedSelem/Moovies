import 'package:flutter/material.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Screens/movie_details.dart';

class FavoriteItems extends StatelessWidget {
  final Movies movie;
  FavoriteItems(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 20,
          right: MediaQuery.of(context).size.width * .011,
          left: MediaQuery.of(context).size.width * .022),
      height: MediaQuery.of(context).size.height * .35,
      width: MediaQuery.of(context).size.width * .45,
      child: GestureDetector(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Image.network(movie.posterUrl),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed(MovieDetails.rounteName, arguments: movie);
        },
      ),
    );
  }
}
