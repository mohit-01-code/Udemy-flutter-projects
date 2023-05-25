import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals.dart';

import 'category_grid.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int currentScreenIndex = 0;
  Widget currentScreen = const CategoryGridScreen();
  String currentScreenTitle = 'Categories';

  @override
  Widget build(BuildContext context) {
    if (currentScreenIndex == 1) {
      currentScreen = MealsScreen(title: 'Your Favourite');
      currentScreenTitle = 'Your Favourite';
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(currentScreenTitle),
      ),
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreenIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favourites'),
        ],
      ),
    );
  }

  void _selectPage(int index) {
    log('INDEX on Tap::: $index');
    setState(() {
      currentScreenIndex = index;
      currentScreen = const CategoryGridScreen();
      currentScreenTitle = 'Categories';
    });
  }
}
