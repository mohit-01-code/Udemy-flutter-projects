import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final File image;
  final double lat, long;
  Place(
      {String? id,
      required this.title,
      required this.image,
      required this.lat,
      required this.long})
      : id = id ?? uuid.v1();
}
