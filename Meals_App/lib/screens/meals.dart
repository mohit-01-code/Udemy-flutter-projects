import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/widget/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final String title;
  String? categoryId;
  Meal? meal;
  List<Meal> meals = [];

  MealsScreen({super.key, required this.title, this.categoryId});

  @override
  Widget build(BuildContext context) {
    setMeal();
    Widget content = ListView.builder(
      itemBuilder: (context, index) {
        return MealItem(
            meal: meals[index],
            onMealPressed: () {
              _onMealPressed(context, meals[index]);
            });
      },
      itemCount: meals.length,
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text(
              'Nothing here...',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Try Selecting different categories',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (categoryId == null) {
      log('Category null returning content without app bar');
      return content;
    } else {
      log('Setting app bar in MEALS screen');

      return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: content);
    }
  }

  void setMeal() {
    meals = dummyMeals
        .where(
          (element) => element.categories.contains(categoryId),
        )
        .toList();
    log('MEALS ::: got title : ${title}');
    log('MEALS ::: got id : ${categoryId}');
    for (int i = 0; i < meals.length; i++) {
      print(meals[i].toString());
    }
  }

  void _onMealPressed(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MealDetailScreen(meal: meal)));
  }
}
