// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/classes/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectHour extends StatelessWidget {
  final String fecha;
  final Doctor doctor;

  const SelectHour({required this.fecha, required this.doctor});

  void _showConfirmationDialog(BuildContext context, String hora) async {
    ApiService apiService = ApiService();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
          ),
          title: Text('Confirmar Cita', style: TextStyle(color: Colors.black)), // Texto negro
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID del Médico: ${doctor.id}', style: TextStyle(color: Colors.black)), // Texto negro
              Text('Nombre: ${doctor.nombres} ${doctor.apellidos}', style: TextStyle(color: Colors.black)), // Texto negro
              Text('Especialidad: ${doctor.especialidades.join(", ")}', style: TextStyle(color: Colors.black)), // Texto negro
              Text('Fecha: $fecha', style: TextStyle(color: Colors.black)), // Texto negro
              Text('Hora: $hora', style: TextStyle(color: Colors.black)), // Texto negro
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF774568), // Fondo morado oscuro
                foregroundColor: Colors.white, // Texto blanco
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? userId = prefs.getInt('userId');
                await apiService.createCita(
                  doctor.id.toString(),
                  userId.toString(),
                  fecha,
                  hora,
                );
                Navigator.of(context).pop();
              },
              child: Text('Confirmar Cita'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turnos'),
        backgroundColor: Color(0xFF774568), // Color morado oscuro
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ícono morado oscuro
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados opcional
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${doctor.especialidades.join(" | ")} | ${doctor.nombres} ${doctor.apellidos}',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black), // Texto negro
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Elegí día y horario',
              style: TextStyle(fontSize: 18.0, color: Colors.black), // Texto negro
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                '${_formatFecha(fecha)}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF774568)), // Texto morado oscuro
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 2.5,
                ),
                itemCount: doctor.horasTrabajo.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF774568), // Fondo morado oscuro
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // Mostrar cuadro de diálogo de confirmación
                        _showConfirmationDialog(
                            context, doctor.horasTrabajo[index]);
                      },
                      child: Text(doctor.horasTrabajo[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatFecha(String fecha) {
    DateTime parsedDate = DateTime.parse(fecha);
    return '${_getWeekday(parsedDate.weekday)} ${parsedDate.day} - ${_getMonth(parsedDate.month)} ${parsedDate.year}';
  }

  String _getWeekday(int weekday) {
    const List<String> weekdays = [
      'LUNES',
      'MARTES',
      'MIÉRCOLES',
      'JUEVES',
      'VIERNES',
      'SÁBADO',
      'DOMINGO'
    ];
    return weekdays[weekday - 1];
  }

  String _getMonth(int month) {
    const List<String> months = [
      'ENERO',
      'FEBRERO',
      'MARZO',
      'ABRIL',
      'MAYO',
      'JUNIO',
      'JULIO',
      'AGOSTO',
      'SEPTIEMBRE',
      'OCTUBRE',
      'NOVIEMBRE',
      'DICIEMBRE'
    ];
    return months[month - 1];
  }
}
