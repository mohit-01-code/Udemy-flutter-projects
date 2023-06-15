import 'dart:io';

import 'package:favourite_place_app/model/place.dart';
import 'package:riverpod/riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sql;

Future<Database> _getDatabase() async {
  final String dbPath = await sql.getDatabasesPath();
  final Database userDb = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_place(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, long REAL)');
    },
    version: 1,
  );

  return userDb;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, double lat, double long) async {
    Directory appDir = await syspath.getApplicationDocumentsDirectory();
    final String filename = path.basename(image.path);
    final File copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace =
        Place(title: title, image: copiedImage, lat: lat, long: long);

    final userDb = await _getDatabase();

    userDb.insert('user_place', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.lat,
      'long': newPlace.long,
    });

    state = [newPlace, ...state];
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final List<Map<String, Object?>> data = await db.query('user_place');
    List<Place> loadedPlaces = data.map((row) {
      return Place(
        id: row['id'] as String,
        title: row['title'] as String,
        image: File(row['image'] as String),
        lat: row['lat'] as double,
        long: row['long'] as double,
      );
    }).toList();

    state = loadedPlaces;
  }

  void deletePlace(Place place) async {
    final db = await _getDatabase();
    db.delete('user_place', where: 'id = ?', whereArgs: [place.id]);
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
