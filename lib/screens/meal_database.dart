import 'package:meals/screens/meal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MealDatabase {
  // Reference to the 'meal' table in Supabase
  final database = Supabase.instance.client.from('meal');

  // Create (Insert a new meal)
  Future<void> addMeal(Meal newMeal) async {
    await database.insert(newMeal.toMap());
  }

  // Read (Stream all meals from the database)
  final stream = Supabase.instance.client.from('meal').stream(
    primaryKey: ['id'],
  ).map(
    (data) => data
        .map(
          (mealMap) => Meal.fromMap(mealMap),
        )
        .toList(),
  );

  // Update (Update an existing meal's title and price)
  Future<void> updateMeal(Meal oldMeal,
      {String? newTitle, double? newPrice}) async {
    final updates = <String, dynamic>{};
    if (newTitle != null) updates['title'] = newTitle;
    if (newPrice != null) updates['price'] = newPrice;

    if (updates.isNotEmpty) {
      await database.update(updates).eq('id', oldMeal.id!);
    }
  }

  // Delete (Remove a meal from the database)
  Future<void> deleteMeal(Meal meal) async {
    await database.delete().eq('id', meal.id!);
  }
}
