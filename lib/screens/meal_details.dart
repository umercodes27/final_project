import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  // Function to add the meal to the cart
  Future<void> addMealToCart(BuildContext context) async {
    final supabase = Supabase.instance.client;

    try {
      // Insert meal into cart table with 'meal_id', 'title', and 'price'
      final response = await supabase.from('cart').insert({
        'meal_id': meal.id,
        'title': meal.title,
        'price': meal.price, // Only use title and price from the meal
      });

      // Check for errors in the response
      if (response.error != null) {
        throw Exception(response.error!.message);
      }

      // Notify the user that the meal has been added to the cart
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meal added to cart successfully!')),
      );
    } catch (error) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding meal to cart: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
          onPressed: () {
            final wasAdded = ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealFavoriteStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),
              ),
            );
          },
          icon: Icon(isFavorite ? Icons.star : Icons.star_border),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl, // Make sure the image URL is available
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Price: \$${meal.price.toStringAsFixed(2)}', // Display price
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: () => addMealToCart(context),
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Order Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
