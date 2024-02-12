import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late List<GroceryItem> _groceryItems;
  late Future<List<GroceryItem>> _loadedItems;

  Future<List<GroceryItem>> _loadItem() async {
    final url = Uri.https(
      'shopping-list-app-f59e2-default-rtdb.asia-southeast1.firebasedatabase.app',
      'shopping_list.json',
    );
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('Failed to load items');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == item.value['category'],
          )
          .value;
      loadedItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }
    return loadedItems;
  }

  @override
  void initState() {
    _loadedItems = _loadItem();
    super.initState();
  }

  Future<List<GroceryItem>> _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) {
          return const NewItem();
        },
      ),
    );
    _groceryItems = await _loadItem();
    return _groceryItems;
  }

  Future<List<GroceryItem>> _removeItem(GroceryItem item) async {
    // Remove from list
    _groceryItems = await _loadedItems;
    final index = _groceryItems.indexWhere((element) => element.id == item.id);
    _groceryItems.remove(item);

    // Remove from database
    final url = Uri.https(
      'shopping-list-app-f59e2-default-rtdb.asia-southeast1.firebasedatabase.app',
      'shopping_list/${item.id}.json',
    );
    final response = await http.delete(url);

    // Add back to list if failed
    if (response.statusCode >= 400) {
      _groceryItems.insert(index, item);
    }
    return _groceryItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final items = _addItem();
              setState(() {
                _loadedItems = items;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items added yet'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(snapshot.data![index].id),
              onDismissed: (direction) {
                final items = _removeItem(snapshot.data![index]);
                setState(() {
                  _loadedItems = items;
                });
              },
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: snapshot.data![index].category.color,
                  ),
                ),
                trailing: Text(
                  snapshot.data![index].quantity.toString(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
