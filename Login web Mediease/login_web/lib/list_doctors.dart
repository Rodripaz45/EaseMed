// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart'; // Importa ApiService
import 'package:login_web/doctor.dart';
import 'package:login_web/doctor_card.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late List<Doctor> doctors = [];

  final ApiService apiService = ApiService(); // Instancia ApiService

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener los médicos al iniciar la pantalla
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      // Llama al método getMedicos de ApiService para obtener los médicos
      List<Doctor> fetchedDoctors = await apiService.getMedicos();

      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (e) {
      // Manejar errores
      print('Error al obtener los médicos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla 1'),
      ),
      body: GridView.count(
        crossAxisCount: 4, // Muestra 3 tarjetas por fila y 3 columnas
        childAspectRatio: 1.2, // Proporción de aspecto de la tarjeta
        mainAxisSpacing: 8.0, // Espacio vertical entre tarjetas
        crossAxisSpacing: 8.0, // Espacio horizontal entre tarjetas
        padding: EdgeInsets.all(8.0), // Espaciado interno del GridView
        children: doctors.map((doctor) => DoctorCard(doctor: doctor)).toList(),
      ),
    );
  }
}
