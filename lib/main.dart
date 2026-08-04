import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const BabyMatchaApp());
}

class BabyMatchaApp extends StatelessWidget {
  const BabyMatchaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Matcha Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffF7F8EE),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff7BAE5A),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}