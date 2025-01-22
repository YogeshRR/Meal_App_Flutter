import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>((ref) {
  return FiltersNotifier();
});
