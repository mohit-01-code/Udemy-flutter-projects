import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/favourite_provider.dart';
import 'package:flutter_provider/provider/opacity_provider.dart';
import 'package:flutter_provider/screen/count_provider_screen.dart';
import 'package:flutter_provider/home_screen.dart';
import 'package:flutter_provider/provider/count_provider.dart';
import 'package:flutter_provider/screen/favourite/favourite_screen.dart';
import 'package:flutter_provider/screen/opacity_screen.dart';
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
    // return ChangeNotifierProvider(
    //   create: (_) {
    //     return ExampleOneProvider();
    //     // return CountProvider();
    //   },
    //   child: MaterialApp(
    //     home: ExampleOneScreen(),
    //   ),
    // );

    //Multi Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountProvider()),
        ChangeNotifierProvider(create: (_) => OpacityProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
      ],
      child: const MaterialApp(
        home: FavouriteScreen(),
      ),
    );
  }
}
