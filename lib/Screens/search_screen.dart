import 'package:flutter/material.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Providers/movie_provider.dart';
import 'package:movies_project/Screens/movie_details.dart';
import 'package:movies_project/Widget/my_drawer.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/searchScreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String movieName;
  List<Movies> movies = [];
  List<MovieDetails> movieDetails = [];
  bool isSuccessful, loading;
  @override
  void initState() {
    super.initState();
    loading = false;
  }

  void search() async {
    setState(() {
      loading = true;
    });
    if (movieName == '') {
      isSuccessful = false;
    } else {
      isSuccessful = await Provider.of<MovieProvider>(context, listen: false)
          .fetchSearchMovies(movieName);
      movies = Provider.of<MovieProvider>(context, listen: false).searchMovies;
      setState(() {
        loading = false;
      });
    }
    // for (int i = 0; i < movies.length; i++) {
    //   movieDetails.add(await Provider.of<MovieProvider>(context, listen: false).fetchMovieDetails(movies[i].id));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  movieName = value;
                });
              },
              onSubmitted: (value) {
                search();
              },
              cursorColor: Theme.of(context).accentColor,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by Movie Name',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                FocusScope.of(context).unfocus();
                search();
              },
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Text(movies[index].title,
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pushNamed(MovieDetails.rounteName,
                          arguments: movies[index]);
                    },
                  );
                },
              ));
  }
}
