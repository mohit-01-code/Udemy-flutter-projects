import 'package:favourite_place_app/screen/place_screen.dart';
import 'package:flutter/material.dart';

import '../model/place.dart';
import 'add_place.dart';

class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({super.key});

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  List<Place> _placeList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Favourite Place"),
          actions: [
            IconButton(
                onPressed: () async {
                  final addedPlace =
                      await Navigator.of(context).push<Place>(MaterialPageRoute(
                    builder: (context) => AddPlaceScreen(),
                  ));
                  if (addedPlace != null) {
                    setState(() {
                      _placeList.add(addedPlace);
                    });
                  }
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
                padding: EdgeInsets.all(8.0),
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PlaceScreen(
                                placeName: _placeList[index].name)));
                      },
                      child: Text(
                        _placeList[index].name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ));
                },
              ));
  }
}
