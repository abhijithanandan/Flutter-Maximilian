import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

const kInitalFilters = {
  FilterType.glutenFree: false,
  FilterType.lactoseFree: false,
  FilterType.vegetarian: false,
  FilterType.vegan: false,
};

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<FilterType, bool> _selectedFilters = {
    FilterType.glutenFree: false,
    FilterType.lactoseFree: false,
    FilterType.vegetarian: false,
    FilterType.vegan: false,
  };

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<FilterType, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            selectedFilters: _selectedFilters,
          ),
        ),
      );
      _selectedFilters = result ?? kInitalFilters;
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[FilterType.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[FilterType.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[FilterType.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[FilterType.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
        ),
        drawer: MainDrawer(
          onSelectScreen: _setScreen,
        ),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ));
  }
}
