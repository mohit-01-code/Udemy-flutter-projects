import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/widget/meal_item.dart';

// ignore: must_be_immutable
class MealsScreen extends StatelessWidget {
  String? title;
  Meal? meal;
  final List<Meal>? meals;
  Widget? content;
  final void Function(Meal meal) onToggleFavourite;

  MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    setContent(context);

    if (title == null) return content!;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }

  void _onMealPressed(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(
          meal: meal,
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
  }

  void setContent(BuildContext context) {
    if (meals!.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            meal: meals![index],
            onMealPressed: () {
              _onMealPressed(context, meals![index]);
            },
          );
        },
        itemCount: meals!.length,
      );
    } else {
      content = Center(
        child: Column(
          children: [
            Text(
              'Nothing here...',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
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
  }
}
