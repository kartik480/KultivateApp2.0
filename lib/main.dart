import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(const KultivateApp());
}

class KultivateApp extends StatelessWidget {
  const KultivateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kultivate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}