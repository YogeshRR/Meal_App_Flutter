import 'package:flutter/material.dart';
import 'package:meals_app/widget/main_drawer.dart';
import 'package:meals_app/widget/tabs.dart';
import 'package:meals_app/widget/filter_switch_list_tile.dart';

enum FilterOptions {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});
  final Map<FilterOptions, bool> currentFilters;
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isGlutenFree = widget.currentFilters[FilterOptions.glutenFree]!;
    _isLactoseFree = widget.currentFilters[FilterOptions.lactoseFree]!;
    _isVegan = widget.currentFilters[FilterOptions.vegan]!;
    _isVegetarian = widget.currentFilters[FilterOptions.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters Screen'),
      ),
      // drawer: MainDrawer(selectetMeal: (identifer) {
      //   Navigator.of(context).pop();

      //   if (identifer == 'meal') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const Tabs(),
      //       ),
      //     );
      //   }
      // }),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            FilterOptions.glutenFree: _isGlutenFree,
            FilterOptions.lactoseFree: _isLactoseFree,
            FilterOptions.vegan: _isVegan,
            FilterOptions.vegetarian: _isVegetarian,
          });
          return false;
        },
        child: Column(
          children: [
            FilterSwitchListTile(
              title: 'Gluten-Free',
              value: _isGlutenFree,
              subTitle: 'Only include Gluten-free meals',
              onChanged: (isUpdated) {
                setState(() {
                  _isGlutenFree = isUpdated;
                });
              },
            ),
            FilterSwitchListTile(
              title: 'Lactose-Free',
              value: _isLactoseFree,
              subTitle: 'Only include Lactose-free meals',
              onChanged: (isUpdated) {
                setState(() {
                  _isLactoseFree = isUpdated;
                });
              },
            ),
            FilterSwitchListTile(
              title: 'Vegan',
              value: _isVegan,
              subTitle: 'Only include Vegan-free meals',
              onChanged: (isUpdated) {
                setState(() {
                  _isVegan = isUpdated;
                });
              },
            ),
            FilterSwitchListTile(
              title: 'Vegetarian',
              value: _isVegetarian,
              subTitle: 'Only include Vegetarian-free meals',
              onChanged: (isUpdated) {
                setState(() {
                  _isVegetarian = isUpdated;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
