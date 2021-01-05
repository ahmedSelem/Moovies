import 'package:dio/dio.dart';
import 'package:movies_project/Models/key_api.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Models/user.dart';

class FireBaseHandler {
  static FireBaseHandler _fireBaseHandler = FireBaseHandler._private();
  FireBaseHandler._private();
  static FireBaseHandler get instance => _fireBaseHandler;

  String mainURL = "https://onlinemovies-f4630.firebaseio.com";
  Dio _dio = Dio();

  Future<void> addFavorite(Movies movie, User user) async {
    String url = '$mainURL/users/${user.id}/favorite/${movie.id}.json';
    final params = {
      'auth': user.idToken,
    };
    await _dio.put(url, queryParameters: params, data: {
      "id": movie.id,
      "title": movie.title,
      "vote_average": movie.rate,
      "backdrop_path": movie.backgroundPosterUrl.split('/').last,
      "poster_path": movie.posterUrl.split('/').last,
    });
  }

  Future<void> removeFavorite(Movies movie, User user) async {
    String url = '$mainURL/users/${user.id}/favorite/${movie.id}.json';
    final params = {
      'auth': user.idToken,
    };
    await _dio.delete(url, queryParameters: params);
  }

  Future<User> signUp(String email, String password) async {
    String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp';
    final params = {
      'key': ApiKey.fireBaseKey,
    };

    Response response = await _dio.post(url, queryParameters: params, data: {
      "email": email,
      "password": password,
      "returnSecureToken": true
    });

    return User.formJson(response.data);
  }

  Future<User> singIn(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
    final params = {'key': ApiKey.fireBaseKey};
    Response response = await _dio.post(url, queryParameters: params, data: {
      'email': email,
      'password': password,
      'returnSecureToken': true
    });

    return User.formJson(response.data);
  }

  Future<User> refreshToken(User user) async {
    String url = 'https://securetoken.googleapis.com/v1/token';
    final params = {'key': ApiKey.fireBaseKey};
    Response response = await _dio.post(url, queryParameters: params, data: {
      'grant_type': 'refresh_token',
      'refresh_token': user.refreshToken,
    });
    user.expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(response.data['expires_in']),
      ),
    );
    user.refreshToken = response.data['refresh_token'];
    user.idToken = response.data['id_token'];
    return user;
  }

  Future<List<Movies>> favvMovies(User user) async {
    String url = '$mainURL/users/${user.id}/favorite.json';
    final params = {
      'auth': user.idToken,
    };
    Response response = await _dio.get(url, queryParameters: params);
    if (response.data != null) {
      List<Movies> favv = (response.data as Map).entries.map((e) {
        return Movies.fromJson(e.value);
      }).toList();
      return favv;
    } else {
      return [];
    }
  }
}
