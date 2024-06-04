import 'package:flutter/material.dart';
import 'package:mediease/classes/doctor.dart';
import 'package:mediease/doctor_screen_details.dart';
import 'package:mediease/selectDate.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final bool canReserve;

  const DoctorCard({required this.doctor, required this.canReserve});

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: NetworkImage(
                    'https://t3.ftcdn.net/jpg/02/48/87/00/360_F_248870078_Wuf8dA4IVf1SB8aH9Ah0HMNYOCNun479.jpg'),
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
