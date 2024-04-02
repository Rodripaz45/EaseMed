import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart'; // Importa ApiService
import 'package:mediease/doctor.dart';
import 'package:mediease/doctor_card.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late List<Doctor> doctors = [];

  final ApiService apiService = ApiService(); // Instancia ApiService

  List<String> _especialidades = [
    'Alergología',
    'Anestesiología',
    'Cardiología',
    'Cirugía',
    'Dermatología',
    'Endocrinología',
    'Gastroenterología',
    'Geriatría',
    'Ginecología',
    'Hematología',
    'Infectología',
    'Medicina de emergencia',
    'Medicina deportiva',
    'Medicina familiar',
    'Medicina interna',
    'Nefrología',
    'Neumología',
    'Neurología',
    'Obstetricia',
    'Oncología',
    'Oftalmología',
    'Ortopedia',
    'Otorrinolaringología',
    'Pediatría',
    'Psiquiatría',
    'Radiología',
    'Reumatología',
    'Traumatología',
    'Urología'
  ];

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener los médicos al iniciar la pantalla
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      // Llama al método getMedicos de ApiService para obtener los médicos
      List<Doctor> fetchedDoctors = await apiService.getMedicos();

      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (e) {
      // Manejar errores
      print('Error al obtener los médicos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla 1'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Muestra un menú emergente con las opciones de filtrado
              _showFilterOptions(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctors[index]);
        },
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filtrar por especialidad'),
          content: SingleChildScrollView(
            child: Column(
              children: _especialidades.map((especialidad) {
                return ListTile(
                  title: Text(especialidad),
                  onTap: () {
                    // Agrega aquí la lógica para aplicar el filtro
                    print('Filtrar por: $especialidad');
                    Navigator.pop(context); // Cierra el diálogo
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
