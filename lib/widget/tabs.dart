import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/Screens/filters_screen.dart';
import 'package:meals_app/Screens/meals_screen.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/Screens/categories_screen.dart';
import 'package:meals_app/widget/main_drawer.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/provider/favouriteMeals_provider.dart';

const kInitialFilters = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegetarian: false,
  FilterOptions.vegan: false,
};

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() {
    // TODO: implement createState
    return _Tabs();
  }
}

class _Tabs extends ConsumerState<Tabs> {
  var activePageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  var _selectedFilter = {
    FilterOptions.glutenFree: false,
    FilterOptions.lactoseFree: false,
    FilterOptions.vegetarian: false,
    FilterOptions.vegan: false,
  };

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilter[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[FilterOptions.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[FilterOptions.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    var title = 'Categories';
    Widget activePage;

    // void _toggleFavouriteMeal(Meal meal) {
    //   final isExisting = _favouriteMeal.contains(meal);

    //   if (isExisting) {
    //     setState(() {
    //       _favouriteMeal.remove(meal);
    //       _showMessage('Favourite meal is removed from Favourite List');
    //     });
    //   } else {
    //     setState(() {
    //       _favouriteMeal.add(meal);
    //       _showMessage('Favourite meal is add in Favourite List');
    //     });
    //   }
    // }

    activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (activePageIndex == 1) {
      print(ref.watch(favouriteMealsProvider));
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        title: 'Favourite Screen',
        meals: favouriteMeals,
      );
      title = 'Your Favourite';
    }

    void _setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        final result =
            await Navigator.of(context).push<Map<FilterOptions, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
              currentFilters: _selectedFilter,
            ),
          ),
        );
        setState(() {
          _selectedFilter = result ?? kInitialFilters;
        });
      }
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(selectetMeal: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourite')
        ],
        onTap: _selectPage,
      ),
    );
  }
}
