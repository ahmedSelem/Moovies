import 'package:flutter/material.dart';

class MovieOverView extends StatelessWidget {
  final String overView;
  MovieOverView(this.overView);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OverView',
            style: Theme.of(context).textTheme.headline5,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              overView,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
