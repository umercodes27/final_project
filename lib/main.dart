import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/auth/auth_gate.dart';
import 'package:meals/screens/tabs.dart';
import "package:supabase_flutter/supabase_flutter.dart";

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  //supabase
  await Supabase.initialize(
    url: 'https://cexyeifdsbjslmcvbmyj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNleHllaWZkc2Jqc2xtY3ZibXlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYwNjQ3ODEsImV4cCI6MjA1MTY0MDc4MX0.3Akd1ycWC5ZBBpGZKto3wqDNVeB_SkhPQkS_uRvjlIU',
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const AuthGate(),
    );
  }
}
