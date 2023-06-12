import 'package:favourite_place_app/model/place.dart';
import 'package:riverpod/riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>>{
  UserPlacesNotifier():super(const []);

  void addPlace(String title){
    final newPlace= Place(name: title);
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider((ref) => UserPlacesNotifier());