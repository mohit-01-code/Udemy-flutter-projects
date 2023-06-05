import 'dart:ui';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class GroceryItem {
  final String id, name;
  final int quantity;
  final Category category;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.category});
}

class Category {
  final String title;
  final Color color;

  const Category(this.title, this.color);
}
