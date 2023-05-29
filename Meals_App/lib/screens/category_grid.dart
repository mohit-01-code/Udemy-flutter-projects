import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widget/category_grid_item.dart';

import '../model/category.dart';
import '../model/meal.dart';
import 'meals.dart';

class CategoryGridScreen extends StatelessWidget {
  const CategoryGridScreen({super.key, required this.onToggleFavourite});
  final void Function(Meal meal) onToggleFavourite;

  @override
  Widget build(context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: availableCategories
          .map((category) => CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _onSelectCategory(context, category);
              }))
          .toList(),
    );
  }

  void _onSelectCategory(BuildContext context, Category category) {
    List<Meal> filteredMeals = dummyMeals
        .where(
          (element) => element.categories.contains(category.id),
        )
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          log('CATEGORY_GRID_ITEM CLICKED::: ${category.title}');
          log('CATEGORY_GRID_ITEM CLICKED::: ${category.id}');
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
            onToggleFavourite: onToggleFavourite,
          );
        },
      ),
    );
  }
}
