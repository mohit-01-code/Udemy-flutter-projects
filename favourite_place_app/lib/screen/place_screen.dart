import 'package:favourite_place_app/model/place.dart';
import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  final Place place;

  const PlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Image.file(
        place.image,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
