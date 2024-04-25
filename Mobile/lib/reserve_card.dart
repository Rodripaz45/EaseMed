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
