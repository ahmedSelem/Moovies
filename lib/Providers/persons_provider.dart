import 'package:flutter/foundation.dart';
import 'package:movies_project/Models/persons.dart';
import 'package:movies_project/Models/tmdb_handler.dart';

class TrendingPersonProvider with ChangeNotifier {
  List<Persons> person;

  Future<bool> fetchTrendingPerson() async {
    try {
      person = await TMDBHandel.getTMDBHandel.getTrendingPerson();
      return true;
    } catch (error) {
      return false;
    }
  }
}
