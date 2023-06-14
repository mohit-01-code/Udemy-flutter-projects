import 'dart:developer';

import 'package:favourite_place_app/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceScreen extends StatelessWidget {
  final Place place;

  const PlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    log("place_screen ::: Latitude{${place.lat}");
    log("place_screen ::: Longitude{${place.long}");
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            margin: const EdgeInsets.all(8.0),
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(place.lat, place.long), zoom: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
