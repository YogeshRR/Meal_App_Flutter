import 'package:flutter/material.dart';

class FilterSwitchListTile extends StatelessWidget {
  final String title;
  final bool value;
  final String subTitle;
  final Function(bool) onChanged;

  const FilterSwitchListTile({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.subTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
