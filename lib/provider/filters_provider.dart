import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum FilterOptions {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  FiltersNotifier()
      : super({
          FilterOptions.glutenFree: false,
          FilterOptions.lactoseFree: false,
          FilterOptions.vegan: false,
          FilterOptions.vegetarian: false,
        });

  void setFilter(Map<FilterOptions, bool> choosenFilters) {
    state = choosenFilters;
  }

  void toggleFilter(FilterOptions filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
    print(state);
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>((ref) {
  return FiltersNotifier();
});

final availableMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[FilterOptions.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
