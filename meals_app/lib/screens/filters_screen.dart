import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          filterTile(context, 'Gluten-free', 'Only include gluten-free meals.',
              activeFilters[Filter.glutenFree]!, (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, isChecked);
          }),
          filterTile(
            context,
            'Lactose-free',
            'Only include lactose-free meals.',
            activeFilters[Filter.lactoseFree]!,
            (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
          ),
          filterTile(context, 'Vegetarian', 'Only include gluten-free meals.',
              activeFilters[Filter.vegetarian]!, (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, isChecked);
          }),
          filterTile(context, 'Vegan', 'Only include gluten-free meals.',
              activeFilters[Filter.vegan]!, (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegan, isChecked);
          }),
        ],
      ),
    );
  }

  SwitchListTile filterTile(
    BuildContext context,
    String title,
    String subtitle,
    bool filterSet,
    Function(bool) updateFilter,
  ) {
    return SwitchListTile(
      value: filterSet,
      onChanged: (isChecked) {
        updateFilter(isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
