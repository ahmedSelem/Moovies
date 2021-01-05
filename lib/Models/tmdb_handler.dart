import 'package:dio/dio.dart';
import 'package:movies_project/Models/genre.dart';
import 'package:movies_project/Models/key_api.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Models/movie_details.dart';
import 'package:movies_project/Models/persons.dart';

class TMDBHandel {
  static TMDBHandel _tmdbHandel = TMDBHandel._private();
  TMDBHandel._private();
  static TMDBHandel get getTMDBHandel => _tmdbHandel;
  String mainUrl = 'https://api.themoviedb.org/3';
  Dio _dio = Dio();

  //Get Now Playing From Api (Server)
  Future<List<Movies>> getNowPlaying() async {
    String url = '$mainUrl/movie/now_playing';
    final parameters = {
      'api_key': ApiKey.tmdbkey,
    };
    Response response = await _dio.get(url, queryParameters: parameters);
    List<Movies> movies = (response.data['results'] as List).map((movie) {
      return Movies.fromJson(movie);
    }).toList();
    return movies;
  }

  //Get Genres From Api (Server)
  Future<List<Genres>> getGenres() async {
    String url = '$mainUrl/genre/movie/list';
    final parameters = {
      'api_key': ApiKey.tmdbkey,
    };
    Response response = await _dio.get(url, queryParameters: parameters);

    List<Genres> genres = (response.data['genres'] as List).map((genre) {
      return Genres.formJson(genre);
    }).toList();

    return genres;
  }

  //Get Movies By Genres Form Api
  Future<List<Movies>> getMovieByGenre(int id) async {
    String url = '$mainUrl/discover/movie';
    final parameters = {'api_key': ApiKey.tmdbkey, 'with_genres': id};

    Response response = await _dio.get(url, queryParameters: parameters);

    List<Movies> movies = (response.data['results'] as List).map((movie) {
      return Movies.fromJson(movie);
    }).toList();
    return movies;
  }

  //STart Trending Persons
  Future<List<Persons>> getTrendingPerson() async {
    String url = '$mainUrl/trending/person/week';
    final key = {'api_key': ApiKey.tmdbkey};
    Response response = await _dio.get(url, queryParameters: key);
    List<Persons> person = (response.data['results'] as List).map((person) {
      return Persons.formJson(person);
    }).toList();
    return person;
  }

  //STart Trending Movies
  Future<List<Movies>> getTrendingMovies() async {
    String url = '$mainUrl/trending/movie/week';
    final key = {'api_key': ApiKey.tmdbkey};
    Response response = await _dio.get(url, queryParameters: key);
    List<Movies> movies = (response.data['results'] as List).map((movie) {
      return Movies.fromJson(movie);
    }).toList();
    return movies;
  }

  //Start Details Movies
  Future<MovieDetailsScreen> getMovieDetails(int movieId) async {
    String url = '$mainUrl/movie/$movieId';
    final key = {'api_key': ApiKey.tmdbkey};
    Response response = await _dio.get(url, queryParameters: key);

    return MovieDetailsScreen.fromJson(response.data);
  }

  Future<String> getVideoByMovieId(int movieId) async {
    String url = '$mainUrl/movie/$movieId/videos';
    final key = {'api_key': ApiKey.tmdbkey};
    Response response = await _dio.get(url, queryParameters: key);

    return response.data['results'][0]['key'];
  }

  // Start Search
  Future<List<Movies>> getSearch(String movieName) async {
    String url = '$mainUrl/search/movie';
    final parameters = {
      'api_key': ApiKey.tmdbkey,
      'query': movieName,
    };
    Response response = await _dio.get(url, queryParameters: parameters);
    List<Movies> movies =  (response.data['results'] as List).map((movie) {
      return Movies.fromJson(movie);
    }).toList();
    return movies;
  }
}
