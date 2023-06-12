import 'package:favourite_place_app/screen/place_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favourite Place',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff9e9e9e),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
          titleSmall: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
          titleMedium: GoogleFonts.ubuntuCondensed(),
          titleLarge: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: PlaceListScreen(),
    );
  }
}
