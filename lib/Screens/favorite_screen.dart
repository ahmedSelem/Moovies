import 'package:flutter/material.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Models/user.dart';
import 'package:movies_project/Providers/movie_provider.dart';
import 'package:movies_project/Providers/user_provider.dart';
import 'package:movies_project/Widget/favorite_items.dart';
import 'package:movies_project/Widget/movies_list.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static const String routeName = '/favscreen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isSucsses, firstRun;
  List<Movies> favmovies;
  @override
  void initState() {
    super.initState();
    firstRun = true;
  }

  @override
  void didChangeDependencies() async {
    if (firstRun) {
      User user = Provider.of<UserProvider>(context).currentUser;
      isSucsses = await Provider.of<MovieProvider>(context, listen: false)
          .fetchFavvMovies(user);
      setState(() {
        firstRun = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    favmovies = Provider.of<MovieProvider>(context, listen: false).favorite;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Favorite Movies'),
        centerTitle: true,
      ),
      body: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (isSucsses)
              ? (favmovies.isEmpty)
                  ? Center(
                      child: Text(
                        'Favorite Is Empty..',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                        ),
                      ),
                    )
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          child: Wrap(
                            children: favmovies.map((favMovie) {
                              return FavoriteItems(favMovie);
                            }).toList(),
                          ),
                        ),
                      ],
                    )
              : Text('Errro'),
    );
  }
}
