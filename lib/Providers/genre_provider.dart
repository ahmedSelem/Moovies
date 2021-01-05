import 'package:flutter/foundation.dart';
import 'package:movies_project/Models/genre.dart';
import 'package:movies_project/Models/tmdb_handler.dart';

class GenreProvider with ChangeNotifier {
  List<Genres> genresTabs;

  Future<bool> fetchGenre() async {
    try {
      genresTabs = await TMDBHandel.getTMDBHandel.getGenres();
      return true;
    } catch (error) {
      return false;
    }
  }

}
