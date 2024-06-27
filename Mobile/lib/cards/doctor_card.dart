import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mediease/classes/doctor.dart';
import 'package:mediease/doctor_screen_details.dart';
import 'package:mediease/selectDate.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final bool canReserve;

  static final List<String> imageUrls = [
    'https://t4.ftcdn.net/jpg/01/34/29/31/360_F_134293169_ymHT6Lufl0i94WzyE0NNMyDkiMCH9HWx.jpg',
    'https://www.shutterstock.com/image-illustration/male-doctor-avatar-3d-illustration-260nw-2205299083.jpg',
    'https://www.shutterstock.com/image-illustration/male-doctor-avatar-3d-illustration-260nw-2205299083.jpg',
    'https://st3.depositphotos.com/1432405/12513/v/450/depositphotos_125136404-stock-illustration-doctor-icon-flat-style.jpg',
    'https://st2.depositphotos.com/4226061/9064/v/950/depositphotos_90647730-stock-illustration-female-doctor-avatar-icon.jpg',
  ];


  const DoctorCard({required this.doctor, required this.canReserve});

  @override
  Widget build(BuildContext context) {
    final int randomImageIndex = Random().nextInt(imageUrls.length);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados opcional
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrls[randomImageIndex]),
                radius: 40.0,
              ),
              SizedBox(height: 8.0),
              Text(
                '${doctor.nombres} ${doctor.apellidos}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black), // Texto negro
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                '${doctor.especialidades.join(', ')}',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF774568), // Fondo morado oscuro
                  foregroundColor: Colors.white, // Texto blanco
                ),
                onPressed: () {
                  if (canReserve) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectDate(doctor: doctor),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(doctor: doctor),
                      ),
                    );
                  }
                },
                child: Text(canReserve ? 'Reservar Cita' : 'Ver Más'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
