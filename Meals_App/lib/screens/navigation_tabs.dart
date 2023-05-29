import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widget/main_drawer.dart';

import '../model/meal.dart';
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
  Widget? currentScreen;
  String currentScreenTitle = 'Categories';
  List<Meal> favouriteMeals = [];

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = CategoryGridScreen(
      onToggleFavourite: _toggleFavouriteStatus,
    );

    if (currentScreenIndex == 1) {
      currentScreen = MealsScreen(
        meals: favouriteMeals,
        onToggleFavourite: _toggleFavouriteStatus,
      );
      currentScreenTitle = 'Your Favourite';
    }
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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

  void _setScreen(String indentifier) {
    if (indentifier == 'filter') {
    } else {
      Navigator.of(context).pop();
    }
  }

  void _selectPage(int index) {
    log('INDEX on Tap::: $index');
    setState(() {
      currentScreenIndex = index;
      currentScreen = CategoryGridScreen(
        onToggleFavourite: _toggleFavouriteStatus,
      );
      currentScreenTitle = 'Categories';
    });
  }

  void _toggleFavouriteStatus(Meal meal) {
    final isExisting = favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        favouriteMeals.remove(meal);
      });
    } else {
      setState(() {
        favouriteMeals.add(meal);
      });
    }
  }
}
