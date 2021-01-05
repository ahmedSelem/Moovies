import 'package:flutter/material.dart';
import 'package:movies_project/Providers/genre_provider.dart';
import 'package:movies_project/Providers/movie_provider.dart';
import 'package:movies_project/Providers/persons_provider.dart';
import 'package:movies_project/Providers/user_provider.dart';
import 'package:movies_project/Screens/authentication_screen.dart';
import 'package:movies_project/Screens/favorite_screen.dart';
import 'package:movies_project/Screens/home_screen.dart';
import 'package:movies_project/Screens/movie_details.dart';
import 'package:movies_project/Screens/search_screen.dart';
import 'package:movies_project/Screens/splash_screen.dart';
import 'package:movies_project/helpers/common.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GenreProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TrendingPersonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode;

  void switchColorMood() {
    if (themeMode == ThemeMode.light) {
      setState(() {
        themeMode = ThemeMode.dark;
      });
    } else {
      setState(() {
        themeMode = ThemeMode.light;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    themeMode = ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).isLogedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.data == true) {
            return HomeScreen();
          } else {
            return AuthenticationScreen();
          }
        },
      ),
      title: 'Online Movies',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color.fromRGBO(231, 76, 60, 1.0),
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Common.color,
        accentColor: Color.fromRGBO(231, 76, 60, 1.0),
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Colors.white70,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Common.color,
      ),
      themeMode: themeMode,
      routes: {
        HomeScreen.rounteName: (context) => HomeScreen(),
        MovieDetails.rounteName: (context) => MovieDetails(),
        AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
        FavoriteScreen.routeName: (context) => FavoriteScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),

      },
    );
  }
}
