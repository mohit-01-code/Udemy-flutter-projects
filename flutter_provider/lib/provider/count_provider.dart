import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountProvider with ChangeNotifier {
  int _count = 50;
  int _seconds = 0;
  int get count => _count;
  int get seconds => _seconds;
  void setCount() {
    _count++;
    notifyListeners();
  }

  void setSeconds() {
    _seconds++;
    notifyListeners();
  }
}
