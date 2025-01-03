import 'package:flutter/material.dart';
import 'package:meals_app/Screens/meals_screen.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/Model/category.dart';
import 'package:meals_app/widget/category_item.dart';
import 'package:meals_app/model/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.toggleFavouriteMeal});

  final Function(Meal meal) toggleFavouriteMeal;
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where(
          (meals) => meals.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          toggleFavouriteMeal: toggleFavouriteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryItem(
            category: category,
            selectedCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
