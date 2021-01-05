import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_project/Models/user.dart';
import 'package:movies_project/Providers/movie_provider.dart';
import 'package:movies_project/Providers/user_provider.dart';
import 'package:movies_project/Screens/movie_details.dart';
import 'package:provider/provider.dart';

class MoviesList extends StatefulWidget {
  final int genreId;
  MoviesList.byGenres(this.genreId);
  MoviesList.trending() : genreId = null;

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool firstRun, isSuccsesful;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    isSuccsesful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      bool done;
      if (widget.genreId != null) {
        done = await Provider.of<MovieProvider>(context)
            .fetchMovieByGenres(widget.genreId);
      } else {
        done = await Provider.of<MovieProvider>(context).fetchTrendingMovies();
      }
      if (mounted) {
        setState(() {
          isSuccsesful = done;
          firstRun = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool lightMood = Theme.of(context).primaryColor == Colors.white;

    return Container(
      height: MediaQuery.of(context).size.height * .35,
      child: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (isSuccsesful)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.genreId != null)
                      ? Provider.of<MovieProvider>(context)
                          .moviesByGenres
                          .length
                      : Provider.of<MovieProvider>(context)
                          .trendingMovies
                          .length,
                  itemExtent: 130,
                  itemBuilder: (context, index) {
                    final movie = (widget.genreId != null)
                        ? Provider.of<MovieProvider>(context)
                            .moviesByGenres[index]
                        : Provider.of<MovieProvider>(context)
                            .trendingMovies[index];
                    bool isFav =
                        Provider.of<MovieProvider>(context, listen: false)
                            .isFavorte(movie.id);
                    return Padding(
                      padding: EdgeInsets.all(6),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              MovieDetails.rounteName,
                              arguments: movie);
                        },
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Image.network(
                                      movie.backgroundPosterUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    movie.title,
                                    style: TextStyle(
                                      color: (lightMood)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: RatingBar(
                                      initialRating: movie.rate / 2,
                                      minRating: 0,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 12,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      onRatingUpdate: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              top: 5,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  // gradient: RadialGradient(
                                    
                                  //   colors: [
                                  //     Theme.of(context).primaryColor,
                                  //     Theme.of(context)
                                  //         .primaryColor
                                  //         .withOpacity(0),
                                  //   ],
                                  // ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    User user = context
                                        .read<UserProvider>()
                                        .currentUser;
                                    bool done = await context
                                        .read<UserProvider>()
                                        .refreshTokenIfNes();
                                    if (done) {
                                      await Provider.of<MovieProvider>(context,
                                              listen: false)
                                          .toggleFav(movie, user);
                                    } else {

                                    }
                                  },
                                  child: Icon(
                                    (isFav)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('Something Wrong'),
                ),
    );
  }
}
