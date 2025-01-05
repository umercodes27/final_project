import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your Category"),
      ),
      body: GridView(
        gridDelegate:
            //no. of columns i want to have cross axis is from l to R, means 2 cols
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                //width of each grid item is 1.5x the height of that
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
        children: [
          Text("1", style: TextStyle(color: Colors.white)),
          Text("2", style: TextStyle(color: Colors.white)),
          Text("3", style: TextStyle(color: Colors.white)),
          Text("4", style: TextStyle(color: Colors.white)),
          Text("5", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
