import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<int> _favourites = [];

  void addFavourite(int index) {
    favourites.add(index);
    notifyListeners();
  }

  void removeFavourite(int index) {
    favourites.remove(index);
    notifyListeners();
  }

  List<int> get favourites => _favourites;

  bool contains(int index) {
    return favourites.contains(index);
  }
}
