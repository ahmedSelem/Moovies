import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_project/Models/firebase_handler.dart';
import 'package:movies_project/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User currentUser;
  Future<void> saveUserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', currentUser.email);
    prefs.setString('userId', currentUser.id);
    prefs.setString('idToken', currentUser.idToken);
    prefs.setString('refreshToken', currentUser.refreshToken);
    prefs.setString('expireDate', currentUser.expiryDate.toString());
  }

  Future<void> clearUserDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('userId');
    prefs.remove('idToken');
    prefs.remove('refreshToken');
    prefs.remove('expireDate');
  }

  Future<String> signUp(String email, String password) async {
    try {
      currentUser = await FireBaseHandler.instance.signUp(email, password);
      await saveUserdata();
      return null;
    } on DioError catch (error) {
      if (error.response.data['error']['message'] == 'EMAIL_EXISTS') {
        return "Email Already Exists";
      } else if (error.response.data['error']['message'] ==
          'TOO_MANY_ATTEMPTS_TRY_LATER') return "Too Many Attempts Try Later";
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      currentUser = await FireBaseHandler.instance.singIn(email, password);
      await saveUserdata();
      return null;
    } on DioError catch (error) {
      print(error.response.data);
      if (error.response.data['error']['message'] == 'EMAIL_NOT_FOUND' ||
          error.response.data['error']['message'] == 'INVALID_PASSWORD') {
        return 'Email Or Password Not Found';
      } else if (error.response.data['error']['message'] == 'USER_DISABLED') {
        return 'This User Disabled';
      }
    }
  }

  Future<bool> isLogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('idToken')) {
      currentUser = User.formPrefs(prefs);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> refreshTokenIfNes() async {
    if (DateTime.now().isAfter(currentUser.expiryDate)) {
      try {
        currentUser = await FireBaseHandler.instance.refreshToken(currentUser);
        await saveUserdata();
        return true;
      } on DioError catch (error) {
        print(error);
        return false;
      }
    } else {
      return true;
    }
  }
}
