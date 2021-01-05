import 'package:flutter/material.dart';
import 'package:movies_project/Providers/genre_provider.dart';
import 'package:movies_project/Widget/movies_list.dart';
import 'package:provider/provider.dart';

class HomeScreenTabs extends StatefulWidget {
  @override
  _HomeScreenTabsState createState() => _HomeScreenTabsState();
}

class _HomeScreenTabsState extends State<HomeScreenTabs>
    with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: Provider.of<GenreProvider>(context, listen: false).genresTabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.50 - 48,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: Provider.of<GenreProvider>(context).genresTabs.map((genre) {
              return Tab(text: genre.name);
            }).toList()
          ),
        ),
        body: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: Provider.of<GenreProvider>(context).genresTabs.map((genre) {
              return MoviesList.byGenres(genre.id);
            }).toList(),
        ),
      ),
    );
  }
}
