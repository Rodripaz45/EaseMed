class Doctor {
  final int id;
  final String nombres;
  final String apellidos;
  final List<String> especialidades;
  final String descripcion;
  final String username;
  final String? horarioInicio; // Nuevo campo
  final String? horarioFin; // Nuevo campo
  final List<String>? diasTrabajo; // Nuevo campo

  Doctor({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.especialidades,
    required this.descripcion,
    required this.username,
    this.horarioInicio, // Modificado para ser opcional
    this.horarioFin, // Modificado para ser opcional
    this.diasTrabajo, // Modificado para ser opcional
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      especialidades: List<String>.from(json['especialidades']),
      descripcion: json['descripcion'],
      username: json['username'],
      horarioInicio: json['horario_inicio'], // Asignar el valor del JSON al campo
      horarioFin: json['horario_fin'], // Asignar el valor del JSON al campo
      diasTrabajo: List<String>.from(json['dias_trabajo']), // Asignar el valor del JSON al campo
    );
  }
}
