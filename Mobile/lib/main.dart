// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mediease/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedEase Login',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Utilizamos un color morado oscuro como tema principal
        appBarTheme: AppBarTheme(
          color: Color(0xFF774568), // Color morado oscuro para todos los AppBar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF774568), // Fondo morado oscuro
            foregroundColor: Colors.white, // Texto blanco
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF774568), // Texto morado oscuro
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
