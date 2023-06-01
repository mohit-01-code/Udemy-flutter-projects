import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/favourite_provider.dart';
import 'package:provider/provider.dart';

class FavouriteListScreen extends StatefulWidget {
  const FavouriteListScreen({super.key});
  @override
  State<FavouriteListScreen> createState() {
    return _FavouriteListState();
  }
}

class _FavouriteListState extends State<FavouriteListScreen> {
  @override
  Widget build(BuildContext context) {
    final favouriteProvider =
        Provider.of<FavouriteProvider>(context, listen: false);
    print("build favourite list...");
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favourites"),
      ),
      body: Consumer<FavouriteProvider>(builder: (context, value, child) {
        return ListView(
          children: value.favourites.map((e) {
            return ListTile(
              title: Text(e.toString()),
              trailing: Icon(Icons.favorite),
              onTap: () {
                value.removeFavourite(e);
              },
            );
          }).toList(),
        );
      }),
    );
  }
}
