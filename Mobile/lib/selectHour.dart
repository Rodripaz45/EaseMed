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
          title: Text('Confirmar Cita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID del Médico: ${doctor.id}'),
              Text('Nombre: ${doctor.nombres} ${doctor.apellidos}'),
              Text('Especialidad: ${doctor.especialidades.join(", ")}'),
              Text('Fecha: $fecha'),
              Text('Hora: $hora'),
            ],
          ),
          actions: [
            ElevatedButton(
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${doctor.especialidades.join(" | ")} | ${doctor.nombres} ${doctor.apellidos}',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Elegí día y horario',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                '${_formatFecha(fecha)}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
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
                        backgroundColor: Colors.lightBlue,
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
