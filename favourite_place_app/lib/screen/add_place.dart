import 'package:favourite_place_app/model/place.dart';
import 'package:flutter/material.dart';

class AddPlaceScreen extends StatelessWidget {
  AddPlaceScreen({super.key});

  final _placeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
                controller: _placeTextController,
                style: Theme.of(context).textTheme.titleMedium!),
            SizedBox(
              height: 20,
            ),
            IntrinsicWidth(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(Place(name: _placeTextController.text));
                  },
                  child: Row(
                    children: [Icon(Icons.add), Text("Add Place")],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
