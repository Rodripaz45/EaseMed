import 'package:flutter/material.dart';
import 'package:mediease/doctor.dart';
import 'package:mediease/doctor_card.dart';

class DoctorProfile extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. William Thompson',
      specialization: 'BDS, MDS-Periodontology and Oral Implantology',
      experience: '16 Years Experience',
      image: 'assets/doctor1.jpeg', // Replace with your image path
    ),
    Doctor(
      name: 'Dr. William Thompson',
      specialization: 'BDS, MDS-Periodontology and Oral Implantology',
      experience: '16 Years Experience',
      image: 'assets/doctor1.jpeg', // Replace with your image path
    ),
    // Add more Doctor objects for other doctors...
  ];

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
