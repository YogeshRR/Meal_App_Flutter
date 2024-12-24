import 'package:flutter/material.dart';
import 'package:meals_app/Screens/meals_screen.dart';
import 'package:meals_app/main.dart';

import 'package:meals_app/Screens/categories_screen.dart';

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
    Widget activePage = const CategoriesScreen();
    var title = 'Categories';

    if (activePageIndex == 1) {
      activePage = const MealsScreen(title: 'Favourite Screen', meals: []);
      title = 'Your Favourite';
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
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
