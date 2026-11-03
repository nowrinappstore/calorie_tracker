import 'package:flutter/material.dart';

import '../models/food_item.dart';

class FoodListItem extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onDelete;

  const FoodListItem({super.key, required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Icon(Icons.restaurant, color: Colors.green.shade700),
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${item.calories} kcal'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          tooltip: 'Delete',
          onPressed: onDelete,
        ),
      ),
    );
  }
}
