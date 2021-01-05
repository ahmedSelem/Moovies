import 'package:flutter/material.dart';
import 'package:movies_project/Providers/user_provider.dart';
import 'package:movies_project/Screens/authentication_screen.dart';
import 'package:movies_project/Screens/favorite_screen.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser.email;
    return Drawer(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Text(
                  '$currentUser',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {},
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favorite Movies'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                  },
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: Text('LogOut'),
                  onTap: () async {
                    await Provider.of<UserProvider>(context, listen: false)
                        .clearUserDate();
                    Navigator.of(context)
                        .pushReplacementNamed(AuthenticationScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
