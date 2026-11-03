import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/food_item.dart';
import '../widgets/add_food_dialog.dart';
import '../widgets/food_list_item.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int dailyGoal = 2000;

  // Local in-memory list. Data resets when the app restarts.
  final List<FoodItem> _foods = [];

  int get _totalCalories =>
      _foods.fold(0, (sum, item) => sum + item.calories);

  int get _remaining => dailyGoal - _totalCalories;

  Future<void> _addFood() async {
    final item = await showAddFoodDialog(context);
    if (item != null) {
      setState(() => _foods.add(item));
    }
  }

  void _deleteFood(FoodItem item) {
    setState(() => _foods.removeWhere((f) => f.id == item.id));
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    final overGoal = _remaining < 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calorie Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  today,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Total Calories',
                    value: '$_totalCalories',
                    icon: Icons.local_fire_department,
                    color: Colors.orange,
                  ),
                ),
                const Expanded(
                  child: SummaryCard(
                    title: 'Daily Goal',
                    value: '$dailyGoal',
                    icon: Icons.flag,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: SummaryCard(
                    title: overGoal ? 'Over Goal' : 'Remaining Calories',
                    value: '${_remaining.abs()}',
                    icon: overGoal ? Icons.warning_amber : Icons.check_circle,
                    color: overGoal ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Food List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: _foods.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.no_food_outlined,
                            size: 64, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'No food added yet.\nTap "Add Food" to get started.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: _foods.length,
                    itemBuilder: (context, index) {
                      final item = _foods[index];
                      return FoodListItem(
                        key: ValueKey(item.id),
                        item: item,
                        onDelete: () => _deleteFood(item),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addFood,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Food'),
      ),
    );
  }
}
