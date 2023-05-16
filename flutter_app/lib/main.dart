import 'package:flutter/material.dart';
import 'package:flutter_app/my_custom_widget.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: MyCustomWidget(Color(0xFF1db954), Color(0xFF191414)), //Constructor called
      ),
    ),
  );
}
