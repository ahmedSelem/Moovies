import 'package:flutter/material.dart';
import 'package:movies_project/Widget/person_list.dart';

class TrendingPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .28,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
              left: 10,
            ),
            child: Text(
              "Trending Persons",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
         PersonList(),
        ],
      ),
    );
  }
}