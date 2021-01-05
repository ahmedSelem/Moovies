import 'package:flutter/material.dart';

class InfoMovieItems extends StatelessWidget {
  final String title, value;
  InfoMovieItems(this.title, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ],
      ),
    );
  }
}
