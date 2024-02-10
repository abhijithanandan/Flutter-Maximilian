import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

enum FilterType {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.selectedFilters});

  final Map<FilterType, bool> selectedFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    _glutenFreeFilterSet = widget.selectedFilters[FilterType.glutenFree]!;
    _lactoseFreeFilterSet = widget.selectedFilters[FilterType.lactoseFree]!;
    _vegetarianFilterSet = widget.selectedFilters[FilterType.vegetarian]!;
    _veganFilterSet = widget.selectedFilters[FilterType.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            FilterType.glutenFree: _glutenFreeFilterSet,
            FilterType.lactoseFree: _lactoseFreeFilterSet,
            FilterType.vegetarian: _vegetarianFilterSet,
            FilterType.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            filterTile(
                context,
                'Gluten-free',
                'Only include gluten-free meals.',
                _glutenFreeFilterSet, (isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            }),
            filterTile(
              context,
              'Lactose-free',
              'Only include lactose-free meals.',
              _lactoseFreeFilterSet,
              (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            filterTile(context, 'Vegetarian', 'Only include gluten-free meals.',
                _vegetarianFilterSet, (isChecked) {
              setState(() {
                _vegetarianFilterSet = isChecked;
              });
            }),
            filterTile(context, 'Vegan', 'Only include gluten-free meals.',
                _veganFilterSet, (isChecked) {
              setState(() {
                _veganFilterSet = isChecked;
              });
            }),
          ],
        ),
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
