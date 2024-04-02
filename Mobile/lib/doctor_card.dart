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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://t3.ftcdn.net/jpg/02/48/87/00/360_F_248870078_Wuf8dA4IVf1SB8aH9Ah0HMNYOCNun479.jpg'),
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Username: ${doctor.username}',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Agrega aquí la lógica para ver más detalles del doctor
                      print('Ver más detalles del doctor');
                    },
                    child: Text('Ver más'),
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
