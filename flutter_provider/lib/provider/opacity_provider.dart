import 'package:flutter/material.dart';

class OpacityProvider with ChangeNotifier {
  double _opacityValue = 0.0;
  double get opacityValue => _opacityValue;
  void setOpacityValue(double newValue) {
    _opacityValue = newValue;
    notifyListeners();
  }
}
