import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/widget/main_drawer.dart';
import 'package:meals_app/widget/tabs.dart';
import 'package:meals_app/widget/filter_switch_list_tile.dart';
import 'package:meals_app/provider/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends ConsumerState<FiltersScreen> {
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _isGlutenFree = activeFilters[FilterOptions.glutenFree]!;
    _isLactoseFree = activeFilters[FilterOptions.lactoseFree]!;
    _isVegan = activeFilters[FilterOptions.vegan]!;
    _isVegetarian = activeFilters[FilterOptions.vegetarian]!;
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
          ref.read(filtersProvider.notifier).setFilter({
            FilterOptions.glutenFree: _isGlutenFree,
            FilterOptions.lactoseFree: _isLactoseFree,
            FilterOptions.vegan: _isVegan,
            FilterOptions.vegetarian: _isVegetarian,
          });

          return true;
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
