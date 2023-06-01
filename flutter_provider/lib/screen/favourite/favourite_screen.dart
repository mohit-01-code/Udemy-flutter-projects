import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/favourite_provider.dart';
import 'package:flutter_provider/screen/favourite/favourite_list_screen.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() {
    return _FavouriteScreenState();
  }
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favouriteProvider =
        Provider.of<FavouriteProvider>(context, listen: false);
    print('build...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavouriteListScreen(),
                ));
              },
              icon: Icon(Icons.favorite)),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  if (!favouriteProvider.contains(index))
                    favouriteProvider.addFavourite(index);
                  else
                    favouriteProvider.removeFavourite(index);
                },
                title: Text("Item $index"),
                trailing: Consumer<FavouriteProvider>(
                  builder: (context, value, child) {
                    return value.contains(index)
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border_outlined);
                  },
                ),
              ),
              const Divider(indent: 12, endIndent: 12),
            ],
          );
        },
      ),
    );
  }
}
