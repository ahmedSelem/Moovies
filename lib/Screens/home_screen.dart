import 'package:flutter/material.dart';
import 'package:movies_project/Models/user.dart';
import 'package:movies_project/Providers/genre_provider.dart';
import 'package:movies_project/Providers/movie_provider.dart';
import 'package:movies_project/Providers/persons_provider.dart';
import 'package:movies_project/Providers/user_provider.dart';
import 'package:movies_project/Screens/search_screen.dart';
import 'package:movies_project/Widget/homeScreen_tabs.dart';
import 'package:movies_project/Widget/homescreen_slider.dart';
import 'package:movies_project/Widget/my_drawer.dart';
import 'package:movies_project/Widget/trending_movies.dart';
import 'package:movies_project/Widget/trending_person.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String rounteName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController;
  bool showButtonScrollTop, firstRun, isSuccessfullResponse;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    showButtonScrollTop = false;
    firstRun = true;
    isSuccessfullResponse = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      bool done = await context.read<UserProvider>().refreshTokenIfNes();
      User user = context.read<UserProvider>().currentUser;
      final responsesList = await Future.wait([
        context.read<MovieProvider>().fetchFavvMovies(user),
        Provider.of<MovieProvider>(context, listen: false)
            .fetchNowPlaingMovies(),
        Provider.of<GenreProvider>(context, listen: false).fetchGenre(),
        Provider.of<TrendingPersonProvider>(context, listen: false)
            .fetchTrendingPerson(),
      ]);
      setState(() {
        isSuccessfullResponse =
            (!responsesList.any((element) => element == false) && done);
        firstRun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool lightMood = Theme.of(context).primaryColor == Colors.white;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Online Movies"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isSuccessfullResponse
              ? SafeArea(
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (notification) {
                      if (scrollController.offset > 15) {
                        setState(() {
                          showButtonScrollTop = true;
                        });
                      } else {
                        setState(() {
                          showButtonScrollTop = false;
                        });
                      }
                      return true;
                    },
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.only(bottom: 48),
                      children: [
                        HomeScreenSlider(),
                        HomeScreenTabs(),
                        TrendingPerson(),
                        TrendingMovies(),
                      ],
                    ),
                  ),
                )
              : Text(
                  'error Accourd',
                  style: TextStyle(color: Colors.white),
                ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (showButtonScrollTop)
            FloatingActionButton(
              mini: true,
              child: Icon(Icons.keyboard_arrow_up),
              onPressed: () {
                scrollController.jumpTo(0.0);
              },
            ),
        ],
      ),
    );
  }
}
