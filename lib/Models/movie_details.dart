import 'package:movies_project/Models/genre.dart';

class MovieDetailsScreen {
  final String overView, releasedate;
  final int budget, runtime;
  final List<Genres> genres;

  MovieDetailsScreen.fromJson(dynamic json)
      : this.overView = json['overview'],
      this.runtime = json['runtime'],
        this.releasedate = json['release_date'],
        this.budget = json['budget'],
        this.genres = (json['genres'] as List).map((genre) {
          return Genres.formJson(genre);
        }).toList();
}
