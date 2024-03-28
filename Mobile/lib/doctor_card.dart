import 'package:flutter/material.dart';
import 'package:mediease/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinear al inicio
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/doctor1.jpeg"), // Asumiendo que tienes imágenes de médicos
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${doctor.nombres} ${doctor.apellidos}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Especialidades: ${doctor.especialidades.join(", ")}',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    doctor.descripcion,
                    style: TextStyle(fontSize: 10.0),
                    maxLines: 2, // Limitar a 2 líneas
                    overflow: TextOverflow.ellipsis, // Mostrar puntos suspensivos si el texto es demasiado largo
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
