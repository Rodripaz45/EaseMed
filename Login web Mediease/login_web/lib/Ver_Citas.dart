import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart';
import 'package:login_web/cita.dart';

class VerCitas extends StatefulWidget {
  @override
  _VerCitasState createState() => _VerCitasState();
}

class _VerCitasState extends State<VerCitas> {
  late List<Cita> citas = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchCitas();
  }

  Future<void> _fetchCitas() async {
    try {
      List<Cita> fetchedCitas = await apiService.getCitas();
      setState(() {
        citas = fetchedCitas;
      });
    } catch (e) {
      print('Error al obtener las citas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas Confirmadas'),
      ),
      body: citas.isEmpty
          ? Center(child: Text('No hay citas confirmadas'))
          : ListView.builder(
              itemCount: citas.length,
              itemBuilder: (context, index) => CitaCard(cita: citas[index]),
            ),
    );
  }
}

class CitaCard extends StatelessWidget {
  final Cita cita;

  const CitaCard({
    Key? key,
    required this.cita,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Subtle shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Optional doctor information header (if available)
          cita.nombreMedico.isNotEmpty
              ? Text(
                  cita.nombreMedico,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              : SizedBox(),
          SizedBox(height: 8),
          Text(
            'ID Cita: ${cita.idCita}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Paciente: ${cita.nombrePaciente}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.date_range, color: Colors.grey, size: 18),
              SizedBox(width: 8),
              Text(
                'Fecha: ${cita.fecha}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.grey, size: 18),
              SizedBox(width: 8),
              Text(
                'Hora: ${cita.hora}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
