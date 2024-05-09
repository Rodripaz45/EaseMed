class Paciente {
  final int id;
  final String nombre;
  final String apellido;
  final DateTime fechaNacimiento;
  final String documentoIdentidad;
  final String telefono;
  final String direccion;

  Paciente({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.documentoIdentidad,
    required this.telefono,
    required this.direccion,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento']),
      documentoIdentidad: json['documento_identidad'],
      telefono: json['telefono'],
      direccion: json['direccion'],
    );
  }
}