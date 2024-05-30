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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildInfoRow('ID:', paciente.id.toString(), Icons.perm_identity),
              SizedBox(height: 10.0),
              _buildInfoRow('Nombre:', '${paciente.nombre} ${paciente.apellido}', Icons.person),
              SizedBox(height: 10.0),
              _buildInfoRow('Fecha de Nacimiento:', _formatDate(paciente.fechaNacimiento), Icons.cake),
              SizedBox(height: 10.0),
              _buildInfoRow('Documento de Identidad:', paciente.documentoIdentidad, Icons.credit_card),
              SizedBox(height: 10.0),
              _buildInfoRow('Teléfono:', paciente.telefono, Icons.phone),
              SizedBox(height: 10.0),
              _buildInfoRow('Dirección:', paciente.direccion, Icons.home),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
