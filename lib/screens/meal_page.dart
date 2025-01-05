import 'package:flutter/material.dart';
import 'package:meals/screens/meal_database.dart';
import 'package:meals/screens/meal.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  // Meals db
  final mealDatabase = MealDatabase();

  // Text controllers
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  // Method to add a meal
  Future<void> addMeal() async {
    final title = titleController.text.trim();
    final price = double.tryParse(priceController.text.trim());

    if (title.isNotEmpty && price != null) {
      final newMeal = Meal(title: title, price: price);
      await mealDatabase.addMeal(newMeal);
      titleController.clear();
      priceController.clear();
    }
  }

  // Method to update a meal
  Future<void> updateMeal(Meal meal) async {
    final title = titleController.text.trim();
    final price = double.tryParse(priceController.text.trim());

    if (title.isNotEmpty && price != null) {
      await mealDatabase.updateMeal(meal, newTitle: title, newPrice: price);
      titleController.clear();
      priceController.clear();
    }
  }

  // Method to delete a meal
  Future<void> deleteMeal(Meal meal) async {
    await mealDatabase.deleteMeal(meal);
  }

  // UI for adding meals
  void showMealDialog({Meal? meal}) {
    if (meal != null) {
      titleController.text = meal.title;
      priceController.text = meal.price.toString();
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(meal == null ? 'Add Meal' : 'Update Meal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (meal == null) {
                await addMeal();
              } else {
                await updateMeal(meal);
              }
              Navigator.of(ctx).pop();
            },
            child: Text(meal == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meals"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMealDialog(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Meal>>(
        stream: mealDatabase.stream,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No meals found. Add some!'),
            );
          }

          final meals = snapshot.data!;

          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) {
              final meal = meals[index];

              return ListTile(
                title: Text(meal.title),
                subtitle: Text('\$${meal.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showMealDialog(meal: meal),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteMeal(meal),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
