import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/classes/qr.dart';
import 'package:mediease/qr_display_screen.dart';

class Reserva {
  final int idCita;
  final int idMedico;
  final String nombreMedico;
  final int idPaciente;
  final String nombrePaciente;
  final DateTime fecha;
  final String hora;

  Reserva({
    required this.idCita,
    required this.idMedico,
    required this.nombreMedico,
    required this.idPaciente,
    required this.nombrePaciente,
    required this.fecha,
    required this.hora,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      idCita: json['id_cita'] as int,
      idMedico: json['id_medico'] as int,
      nombreMedico: json['nombre_medico'] as String,
      idPaciente: json['id_paciente'] as int,
      nombrePaciente: json['nombre_paciente'] as String,
      fecha: DateTime.parse(json['fecha']),
      hora: json['hora'] as String,
    );
  }
}

class ReservaCard extends StatelessWidget {
  final Reserva reserva;

  ReservaCard({required this.reserva});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
      ),
      margin: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              color: Color(0xFF774568), // Fondo morado oscuro
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Fecha: ${reserva.fecha.toString().split(' ')[0]}',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Hora: ${reserva.hora}',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Cita #${reserva.idCita}',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Médico: ${reserva.nombreMedico}',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Paciente: ${reserva.nombrePaciente}',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF774568), // Texto blanco
                    ),
                    onPressed: () {
                      _showPaymentDialog(context);
                    },
                    child: Text('Pagar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    TextEditingController _paymentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el número de pago'),
          content: TextField(
            controller: _paymentController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Número de pago'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String paymentNumber = _paymentController.text;
                _generateQR(context, paymentNumber);
              },
              child: Text('Generar'),
            ),
          ],
        );
      },
    );
  }

  void _generateQR(BuildContext context, String paymentNumber) {
    ApiService apiService = new ApiService();
    Future<QR> qr = apiService.generarQR(paymentNumber);
    qr.then((qrObject) {
      print('QR generado: $qrObject');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QRDisplayScreen(
                  qr: qrObject,
                )),
      );
      // Aquí puedes hacer cualquier otra acción con el objeto QR
    }).catchError((error) {
      print('Error al generar QR: $error');
    });
  }
}
