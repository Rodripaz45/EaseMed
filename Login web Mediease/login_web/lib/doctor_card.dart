import 'package:flutter/material.dart';
import 'package:login_web/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/02/48/87/00/360_F_248870078_Wuf8dA4IVf1SB8aH9Ah0HMNYOCNun479.jpg'),
              radius: 40.0, // Tamaño del círculo de la imagen
            ),
            SizedBox(height: 16.0),
            Text(
              '${doctor.nombres} ${doctor.apellidos}',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Especialidades: ${doctor.especialidades.join(", ")}',
              style: TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              doctor.descripcion,
              style: TextStyle(fontSize: 10.0),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
