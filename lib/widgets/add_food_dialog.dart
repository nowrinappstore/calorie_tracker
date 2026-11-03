import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/food_item.dart';

/// Shows a dialog to enter a food name and calories.
/// Returns a [FoodItem] when the user submits valid data, otherwise null.
Future<FoodItem?> showAddFoodDialog(BuildContext context) {
  return showDialog<FoodItem>(
    context: context,
    builder: (_) => const _AddFoodDialog(),
  );
}

class _AddFoodDialog extends StatefulWidget {
  const _AddFoodDialog();

  @override
  State<_AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<_AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final item = FoodItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      calories: int.parse(_caloriesController.text.trim()),
    );
    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Food'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Food Name',
                prefixIcon: Icon(Icons.fastfood_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a food name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Calories (kcal)',
                prefixIcon: Icon(Icons.local_fire_department_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the calorie amount';
                }
                final calories = int.tryParse(value.trim());
                if (calories == null || calories <= 0) {
                  return 'Enter a valid positive number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
