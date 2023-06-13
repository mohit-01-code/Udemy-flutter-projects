import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});
  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  bool _gettingLocation = false;
  LocationData? currentLocation;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Theme.of(context).colorScheme.primary)),
          child: _gettingLocation
              ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                )
              : Text(
                  "No Location Chosen",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Get Current Location")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text("Select on Map")),
          ],
        )
      ],
    );
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    //checking if location is On/Off
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      //if location is off...request for turn off location
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _gettingLocation = true;
    });

    currentLocation = await location.getLocation();

    setState(() {
      _gettingLocation = false;
    });

    log(currentLocation!.latitude.toString());
    log(currentLocation!.longitude.toString());
  }
}
