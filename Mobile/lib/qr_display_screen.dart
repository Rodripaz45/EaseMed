import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mediease/classes/qr.dart';

class QRDisplayScreen extends StatelessWidget {
  final QR qr;

  QRDisplayScreen({required this.qr});

  @override
  Widget build(BuildContext context) {
    // Decodificar la imagen base64
    Uint8List imageBytes = Uint8List.fromList(base64Decode(qr.qrImage));
    return Scaffold(
      appBar: AppBar(
        title: Text('Código QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QR generado:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Mostrar la imagen decodificada
            Image.memory(
              imageBytes,
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
