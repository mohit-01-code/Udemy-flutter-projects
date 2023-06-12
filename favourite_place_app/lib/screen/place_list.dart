import 'package:favourite_place_app/provider/user_place.dart';
import 'package:favourite_place_app/screen/place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place.dart';
import 'add_place.dart';

class PlaceListScreen extends ConsumerWidget {
  PlaceListScreen({super.key});
  List<Place> _placeList = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _placeList = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Favourite Place"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: _placeList.isEmpty
          ? Center(
              child: Text(
                "No Place Added Yet",
                style: Theme.of(context).textTheme.titleMedium!,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(_placeList[index].image),
                    radius: 26,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => PlaceScreen(place: _placeList[index]),
                      ),
                    );
                  },
                  title: Text(
                    _placeList[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              },
            ),
    );
  }
}
