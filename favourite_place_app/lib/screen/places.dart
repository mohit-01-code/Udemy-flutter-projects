import 'package:favourite_place_app/provider/user_place.dart';
import 'package:favourite_place_app/widget/place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place.dart';
import 'add_place.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key});

  @override
  ConsumerState<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends ConsumerState<PlaceListScreen> {
  List<Place> _placeList = [];
  late Future<void> _placeFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placeFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _placeFuture,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                )
              : PlaceList(
                  placeList: _placeList,
                  onDeletePlace: deletePlace,
                );
        },
      ),
    );
  }

  void deletePlace(Place place) {
    ref.read(userPlaceProvider.notifier).deletePlace(place);
    _placeFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }
}
