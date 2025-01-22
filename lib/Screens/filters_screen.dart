import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/widget/filter_switch_list_tile.dart';
import 'package:meals_app/provider/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters Screen'),
      ),
      body: Column(
        children: [
          FilterSwitchListTile(
            title: 'Gluten-Free',
            value: activeFilters[FilterOptions.glutenFree]!,
            subTitle: 'Only include Gluten-free meals',
            onChanged: (isUpdated) {
              ref
                  .read(filtersProvider.notifier)
                  .toggleFilter(FilterOptions.glutenFree, isUpdated);
            },
          ),
          FilterSwitchListTile(
            title: 'Lactose-Free',
            value: activeFilters[FilterOptions.lactoseFree]!,
            subTitle: 'Only include Lactose-free meals',
            onChanged: (isUpdated) {
              ref
                  .read(filtersProvider.notifier)
                  .toggleFilter(FilterOptions.lactoseFree, isUpdated);
            },
          ),
          FilterSwitchListTile(
            title: 'Vegan',
            value: activeFilters[FilterOptions.vegan]!,
            subTitle: 'Only include Vegan-free meals',
            onChanged: (isUpdated) {
              ref
                  .read(filtersProvider.notifier)
                  .toggleFilter(FilterOptions.vegan, isUpdated);
            },
          ),
          FilterSwitchListTile(
            title: 'Vegetarian',
            value: activeFilters[FilterOptions.vegetarian]!,
            subTitle: 'Only include Vegetarian-free meals',
            onChanged: (isUpdated) {
              ref
                  .read(filtersProvider.notifier)
                  .toggleFilter(FilterOptions.vegetarian, isUpdated);
            },
          ),
        ],
      ),
    );
  }
}
