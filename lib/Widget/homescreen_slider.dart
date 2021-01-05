import 'package:flutter/material.dart';
import 'package:movies_project/Models/movie.dart';
import 'package:movies_project/Providers/movie_provider.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreenSlider extends StatefulWidget {
  @override
  _HomeScreenSliderState createState() => _HomeScreenSliderState();
}

class _HomeScreenSliderState extends State<HomeScreenSlider> {
  Movies movie;
 


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: PageIndicatorContainer(
        indicatorSelectorColor: Theme.of(context).accentColor,
        shape: IndicatorShape.circle(size: 8),
        length: 5,
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            movie = Provider.of<MovieProvider>(context).nowPlayingMovies[index];
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    movie.backgroundPosterUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //       colors: [
                  //         Theme.of(context).primaryColor.withOpacity(.9),
                  //         Theme.of(context).primaryColor.withOpacity(.3),
                  //       ],
                  //       begin: Alignment.bottomCenter,
                  //       end: Alignment.topCenter,
                  //       stops: [0, 1]),
                  // ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.play_circle_outline,
                      size: 60,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return null;
                        }),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 15,
                  child: Container(
                    width: 120,
                    child: Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
