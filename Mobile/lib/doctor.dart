class Doctor {
  final int id;
  final String nombres;
  final String apellidos;
  final List<String> especialidades;
  final String descripcion;
  final String username;
  final String? horarioInicio;
  final String? horarioFin;
  final List<String>? diasTrabajo;
  late List<String> horasTrabajo; // Lista de horas de trabajo

  Doctor({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.especialidades,
    required this.descripcion,
    required this.username,
    this.horarioInicio,
    this.horarioFin,
    this.diasTrabajo,
  }) {
    generarHorasTrabajo(); // Generar la lista de horas de trabajo al crear el objeto Doctor
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      especialidades: List<String>.from(json['especialidades']),
      descripcion: json['descripcion'],
      username: json['username'],
      horarioInicio: json['horario_inicio'],
      horarioFin: json['horario_fin'],
      diasTrabajo: List<String>.from(json['dias_trabajo']),
    );
  }

  void generarHorasTrabajo() {
    horasTrabajo = [];
    if (horarioInicio != null && horarioFin != null) {
      DateTime? inicio = parseTime(horarioInicio!);
      DateTime? fin = parseTime(horarioFin!);
      if (inicio != null && fin != null) {
        while (inicio!.isBefore(fin)) {
          horasTrabajo.add(inicio.toIso8601String().substring(11, 16));
          inicio = inicio.add(Duration(minutes: 30));
        }
      }
    }
  }

  DateTime? parseTime(String timeString) {
    try {
      return DateTime.parse('2022-01-01T$timeString');
    } catch (e) {
      print('Error parsing time: $e');
      return null;
    }
  }
}
