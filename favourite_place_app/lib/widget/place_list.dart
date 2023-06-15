import 'package:flutter/material.dart';

import '../model/place.dart';
import '../screen/place_screen.dart';

class PlaceList extends StatelessWidget {
  const PlaceList(
      {super.key, required this.placeList, required this.onDeletePlace});
  final List<Place> placeList;
  final void Function(Place place) onDeletePlace;

  @override
  Widget build(BuildContext context) {
    return placeList.isEmpty
        ? Center(
            child: Text(
              "No Place Added Yet",
              style: Theme.of(context).textTheme.titleMedium!,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: placeList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(placeList[index].id),
                onDismissed: (direction) {
                  onDeletePlace(placeList[index]);
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(placeList[index].image),
                    radius: 26,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => PlaceScreen(place: placeList[index]),
                      ),
                    );
                  },
                  title: Text(
                    placeList[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            },
          );
  }
}
