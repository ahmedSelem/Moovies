import 'package:flutter/material.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Models/movie_details.dart';
import 'package:movies_project/Providers/movie_provider.dart';
import 'package:movies_project/Widget/genres_movie_details.dart';
import 'package:movies_project/Widget/info_movies.dart';
import 'package:movies_project/Widget/movie_overview.dart';
import 'package:movies_project/Widget/rate_bar.dart';
import 'package:movies_project/Widget/vider_screen.dart';
import 'package:provider/provider.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetails extends StatefulWidget {
  static const String rounteName = '/movie-details';

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  MovieDetailsScreen movieDetailsScreen;
  String videoKey;
  Movies movie;
  bool firstRun, isSuccssesful;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    isSuccssesful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      movie = ModalRoute.of(context).settings.arguments as Movies;

      List results = await Future.wait([
        Provider.of<MovieProvider>(context).fetchMovieDetails(movie.id),
        Provider.of<MovieProvider>(context).fetchVideoByMovieId(movie.id)
      ]);
      if (mounted) {
        setState(() {
          if (results.any((element) => element == null)) {
            isSuccssesful = false;
          } else {
            movieDetailsScreen = results[0];
            videoKey = results[1];
            isSuccssesful = true;
          }
          firstRun = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (isSuccssesful)
              ? SliverFab(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height * .4,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Container(
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                            margin: EdgeInsets.only(right: 90)),
                        background: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.network(
                                movie.backgroundPosterUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              // decoration: BoxDecoration(
                              //   gradient: LinearGradient(
                              //       colors: [
                              //         Theme.of(context)
                              //             .primaryColor
                              //             .withOpacity(.9),
                              //         Theme.of(context)
                              //             .primaryColor
                              //             .withOpacity(.3),
                              //       ],
                              //       begin: Alignment.bottomCenter,
                              //       end: Alignment.topCenter,
                              //       stops: [0, .8]),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RateBarDetails(movie.rate),
                                MovieOverView(movieDetailsScreen.overView),
                                InfoMovies(
                                  movieDetailsScreen.budget.toString(),
                                  movieDetailsScreen.runtime.toString(),
                                  movieDetailsScreen.releasedate,
                                ),
                                GenreMovieDetails(movieDetailsScreen.genres),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                  floatingWidget: FloatingActionButton(
                    child: Icon(Icons.play_circle_outline),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) {
                            return VideoScreen(videoKey);
                          },
                        ),
                      );
                    },
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * .4,
                )
              : Center(
                  child: Text(
                  'Wrong Occurd',
                  style: TextStyle(color: Colors.white),
                )),
    );
  }
}
