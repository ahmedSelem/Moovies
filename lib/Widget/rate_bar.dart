import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateBarDetails extends StatelessWidget {
  final double rate;
  RateBarDetails(this.rate); 
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30, bottom: 20),
        child: RatingBar(
          ignoreGestures: false,
          itemCount: 5,
          allowHalfRating: true,
          initialRating: rate / 2,
          minRating: 0,
          itemBuilder: (context, _) =>
              Icon(Icons.star, color: Theme.of(context).accentColor),
          onRatingUpdate: null,
          itemSize: 20,
        ));
  }
}
