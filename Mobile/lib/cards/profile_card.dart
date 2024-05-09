import 'package:flutter/material.dart';
import 'package:mediease/classes/paciente.dart';
import 'package:mediease/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PacienteCard extends StatefulWidget {
  @override
  _PacienteCardState createState() => _PacienteCardState();
}

class _PacienteCardState extends State<PacienteCard> {
  late Future<Paciente> _pacienteFuture;
  final ApiService _apiService = ApiService(); // Instancia de ApiService

  @override
  void initState() {
    super.initState();
    _pacienteFuture = _fetchPaciente(); // Inicializar _pacienteFuture
  }

  Future<Paciente> _fetchPaciente() async {
    try {
      final id = await _getCachedPacienteId();
      return _apiService.getPacienteById(id);
    } catch (e) {
      throw Exception('Error al obtener el paciente: $e');
    }
  }

  Future<int> _getCachedPacienteId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userId');
    if (id != null) {
      return id;
    } else {
      throw Exception('ID de paciente no encontrado en las preferencias compartidas');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: FutureBuilder<Paciente>(
          future: _pacienteFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return _buildPacienteCard(snapshot.data!);
            } else {
              return Text('No se pudo obtener los datos del paciente');
            }
          },
        ),
      ),
    );
  }

  Widget _buildPacienteCard(Paciente paciente) {
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ID: ${paciente.id}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('Nombre: ${paciente.nombre} ${paciente.apellido}'),
            SizedBox(height: 5.0),
            Text('Fecha de Nacimiento: ${paciente.fechaNacimiento}'),
            SizedBox(height: 5.0),
            Text('Documento de Identidad: ${paciente.documentoIdentidad}'),
            SizedBox(height: 5.0),
            Text('Teléfono: ${paciente.telefono}'),
            SizedBox(height: 5.0),
            Text('Dirección: ${paciente.direccion}'),
          ],
        ),
      ),
    );
  }
}
