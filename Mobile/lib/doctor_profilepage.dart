import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart'; // Importa ApiService
import 'package:mediease/doctor.dart';
import 'package:mediease/doctor_card.dart';

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
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctors[index]);
        },
      ),
    );
  }
}
