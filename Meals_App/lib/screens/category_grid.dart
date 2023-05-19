import 'package:flutter/cupertino.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widget/category_grid_item.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

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
          .map((category) => CategoryGridItem(category: category))
          .toList(),
    );
  }
}
