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
        primarySwatch: Colors.red, // Utilizamos el color rojo como tema principal
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
