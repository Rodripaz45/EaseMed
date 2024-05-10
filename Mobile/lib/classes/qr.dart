import 'dart:convert';

class QR {
  final int error;
  final int status;
  final String message;
  final int messageMostrar;
  final String messageSistema;
  final String values;
  final String id;
  final String qrImage;
  final String expirationDate;

  QR({
    required this.error,
    required this.status,
    required this.message,
    required this.messageMostrar,
    required this.messageSistema,
    required this.values,
    required this.id,
    required this.qrImage,
    required this.expirationDate,
  });

  factory QR.fromJson(Map<String, dynamic> json) {
    return QR(
      error: json['error'] as int,
      status: json['status'] as int,
      message: json['message'] as String,
      messageMostrar: json['messageMostrar'] as int,
      messageSistema: json['messageSistema'] as String,
      values: json['values'] as String,
      id: (json['values'] as String).split(';').first,
      qrImage: jsonDecode((json['values'] as String).split(';').last)['qrImage'],
      expirationDate: jsonDecode((json['values'] as String).split(';').last)['expirationDate'],
    );
  }

  String get qrImageBase64 => base64Encode(utf8.encode(qrImage));

  @override
  String toString() {
    return 'QR { error: $error, status: $status, message: $message, messageMostrar: $messageMostrar, messageSistema: $messageSistema, values: $values, id: $id, qrImage: $qrImage, expirationDate: $expirationDate }';
  }
}
