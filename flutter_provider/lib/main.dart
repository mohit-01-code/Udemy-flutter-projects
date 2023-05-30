import 'package:flutter/material.dart';
import 'package:flutter_provider/count_provider_screen.dart';
import 'package:flutter_provider/home_screen.dart';
import 'package:flutter_provider/provider/count_provider.dart';
import 'package:flutter_provider/statefull_screen.dart';
import 'package:flutter_provider/why_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //     home: StatefullScreen(),
    // );
    return ChangeNotifierProvider(
      create: (_) {
        return CountProvider();
      },
      child: MaterialApp(
        home: CountProviderScreen(),
      ),
    );
  }
}
