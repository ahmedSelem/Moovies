import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies_project/Models/firebase_handler.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Models/movie_details.dart';
import 'package:movies_project/Models/tmdb_handler.dart';
import 'package:movies_project/Models/user.dart';

class MovieProvider with ChangeNotifier {
  List<Movies> nowPlayingMovies,
      moviesByGenres,
      trendingMovies,
      favorite = [],
      searchMovies = [];

  Future<List<Movies>> fetchNowPlaingMovies() async {
    try {
      nowPlayingMovies = await TMDBHandel.getTMDBHandel.getNowPlaying();
      return nowPlayingMovies;
    } catch (error) {
      return null;
    }
  }

  Future<bool> fetchMovieByGenres(int genreId) async {
    try {
      moviesByGenres = await TMDBHandel.getTMDBHandel.getMovieByGenre(genreId);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchTrendingMovies() async {
    try {
      trendingMovies = await TMDBHandel.getTMDBHandel.getTrendingMovies();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<MovieDetailsScreen> fetchMovieDetails(int movieId) async {
    try {
      MovieDetailsScreen movieDetails =
          await TMDBHandel.getTMDBHandel.getMovieDetails(movieId);
      return movieDetails;
    } catch (error) {
      return null;
    }
  }

  Future<String> fetchVideoByMovieId(int movieId) async {
    try {
      return TMDBHandel.getTMDBHandel.getVideoByMovieId(movieId);
    } catch (error) {
      return null;
    }
  }

  Future<void> toggleFav(Movies movies, User user) async {
    try {
      if (isFavorte(movies.id)) {
        await FireBaseHandler.instance.removeFavorite(movies, user);
        favorite.removeWhere((element) => element.id == movies.id);
      } else {
        await FireBaseHandler.instance.addFavorite(movies, user);
        favorite.add(movies);
      }
    } on DioError catch (error) {
      print(error.response.data);
    }
    notifyListeners();
  }

  bool isFavorte(int movieId) {
    return favorite.any((element) => element.id == movieId);
  }

  Future<bool> fetchFavvMovies(User user) async {
    try {
      favorite = await FireBaseHandler.instance.favvMovies(user);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> fetchSearchMovies(String movieName) async {
    try {
      searchMovies = await TMDBHandel.getTMDBHandel.getSearch(movieName);
      return true;
    } catch (error) {
      return false;
    }
  }
}
