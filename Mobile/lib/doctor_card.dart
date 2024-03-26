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
          children: [
            CircleAvatar(
              backgroundImage:
                   AssetImage("assets/doctor1.jpeg")// Assuming you have image assets
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.name, style: TextStyle(fontSize: 18.0)),
                Text(doctor.specialization, style: TextStyle(fontSize: 14.0)),
                Text(doctor.experience, style: TextStyle(fontSize: 12.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
