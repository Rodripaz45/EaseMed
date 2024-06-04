import 'package:flutter/material.dart';
import 'package:mediease/classes/consulta.dart';

class ConsultaCard extends StatelessWidget {
  final Consulta consulta;

  ConsultaCard({required this.consulta});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados opcional
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fecha: ${consulta.fecha}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Texto negro
              ),
              SizedBox(height: 8.0),
              Text('Diagnóstico: ${consulta.diagnostico}', style: TextStyle(color: Colors.black)), // Texto negro
              SizedBox(height: 8.0),
              Text('Receta Médica: ${consulta.recetaMedica}', style: TextStyle(color: Colors.black)), // Texto negro
              SizedBox(height: 8.0),
              Text('Observaciones: ${consulta.observaciones}', style: TextStyle(color: Colors.black)), // Texto negro
            ],
          ),
        ),
      ),
    );
  }
}
