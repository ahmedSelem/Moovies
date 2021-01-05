import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String email, id;
  DateTime expiryDate;
  String idToken, refreshToken;

  User.formJson(dynamic json)
      : this.email = json['email'],
        this.id = json['localId'],
        this.idToken = json['idToken'],
        this.refreshToken = json['refreshToken'],
        this.expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              json['expiresIn'],
            ),
          ),
        );

  User.formPrefs(SharedPreferences prefs)
      : this.email = prefs.get('email'),
        this.id = prefs.get('userId'),
        this.idToken = prefs.get('idToken'),
        this.refreshToken = prefs.get('refreshToken'),
        this.expiryDate = DateTime.parse(
          prefs.get('expireDate'),
        );
}
