import 'package:flutter/material.dart';
import 'package:movies_project/Providers/persons_provider.dart';
import 'package:provider/provider.dart';

class PersonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Provider.of<TrendingPersonProvider>(context, listen: false)
            .person
            .length,
        itemExtent: 120,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(bottom: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        Provider.of<TrendingPersonProvider>(context)
                            .person[index]
                            .posterPath,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Text(
                        Provider.of<TrendingPersonProvider>(context)
                            .person[index]
                            .name,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
