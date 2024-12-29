import 'package:flutter/material.dart';
import 'package:meals_app/Screens/meals_screen.dart';
import 'package:meals_app/model/meal.dart';

import 'package:meals_app/Screens/categories_screen.dart';
import 'package:meals_app/widget/main_drawer.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() {
    // TODO: implement createState
    return _Tabs();
  }
}

class _Tabs extends State<Tabs> {
  var activePageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> _favouriteMeal = [];
    var title = 'Categories';
    Widget activePage;
    void _showMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    void _toggleFavouriteMeal(Meal meal) {
      final isExisting = _favouriteMeal.contains(meal);

      if (isExisting) {
        setState(() {
          _favouriteMeal.remove(meal);
          _showMessage('Favourite meal is removed from Favourite List');
        });
      } else {
        setState(() {
          _favouriteMeal.add(meal);
          _showMessage('Favourite meal is add in Favourite List');
        });
      }
    }

    activePage = CategoriesScreen(toggleFavouriteMeal: _toggleFavouriteMeal);

    if (activePageIndex == 1) {
      activePage = MealsScreen(
        title: 'Favourite Screen',
        meals: _favouriteMeal,
        toggleFavouriteMeal: _toggleFavouriteMeal,
      );
      title = 'Your Favourite';
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(),
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
