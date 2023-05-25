enum Affordability { affordable, pricey, luxurious }

enum Complexity { simple, challenging, hard }

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  final Affordability affordability;
  final Complexity complexity;

  Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.affordability,
    required this.complexity,
    required this.imageUrl,
    required this.duration,
    required this.ingredients,
    required this.steps,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree,
  });

  @override
  String toString() {
    return "{\n"
        "id: $id,\n"
        "categories: ${categories.toString()},\n"
        "title: $title,\n"
        "imageUrl: $imageUrl,\n"
        "duration: ${duration.toString()},\n"
        "ingredients: ${ingredients.toString()},\n"
        "steps: ${steps.toString()},\n"
        "isGlutenFree: $isGlutenFree,\n"
        "isVegan: $isVegan,\n"
        "isVegetarian: $isVegetarian,\n"
        "affordability: ${affordability.name},\n"
        "complexity: ${complexity.name}}";
  }
}
