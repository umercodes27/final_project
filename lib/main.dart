import 'package:final_project/screens/categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// The `final` keyword is used to declare a variable that can only be set once.
final theme = ThemeData(
  useMaterial3: true,
  /*
  This means that the primary colors of the theme are derived from the specified seed color.
  The seed color acts as a base, and the ColorScheme.fromSeed method generates 
  a cohesive set of colors that work well together, maintaining a consistent look and feel throughout the application.
  */
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}
