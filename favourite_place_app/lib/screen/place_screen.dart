import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  final String placeName;


  const PlaceScreen({super.key, required this.placeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(placeName),
      ),
      body: Center(child: Text(placeName, style: Theme.of(context).textTheme.titleMedium,),),
    );
  }
}
