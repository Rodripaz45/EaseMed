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
        primarySwatch: Colors.blue, // Utilizamos el color rojo como tema principal
        appBarTheme: AppBarTheme(
          color: Colors.blue, // Color azul para todos los AppBar
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
