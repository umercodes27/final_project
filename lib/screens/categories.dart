import 'package:final_project/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:final_project/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your Category"),
      ),
      body: GridView(
        padding: EdgeInsets.all(25),
        gridDelegate:
            //no. of columns i want to have cross axis is from l to R, means 2 cols
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //width of each grid item is 1.5x the height of that
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(category: category)
        ],
      ),
    );
  }
}
