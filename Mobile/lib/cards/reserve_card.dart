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
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text('Cita #${reserva.idCita}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Médico: ${reserva.nombreMedico}'),
            Text('Paciente: ${reserva.nombrePaciente}'),
            Text('Fecha: ${reserva.fecha.toString().split(' ')[0]}'),
            Text('Hora: ${reserva.hora}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showPaymentDialog(context);
              },
              child: Text('Generar QR'),
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
                // Aquí puedes llamar a la función para generar el QR con el número de pago
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