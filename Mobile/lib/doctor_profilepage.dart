import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/doctor.dart';
import 'package:mediease/doctor_card.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late List<Doctor> _originalDoctors = [];
  late List<Doctor> _filteredDoctors = [];
  final ApiService apiService = ApiService();
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

  String? _selectedEspecialidad;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      List<Doctor> fetchedDoctors = await apiService.getMedicos();
      setState(() {
        _originalDoctors = fetchedDoctors;
        _filteredDoctors = fetchedDoctors;
      });
    } catch (e) {
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
              _showFilterOptions(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredDoctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: _filteredDoctors[index]);
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
                return RadioListTile<String>(
                  title: Text(especialidad),
                  value: especialidad,
                  groupValue: _selectedEspecialidad,
                  onChanged: (value) {
                    setState(() {
                      _selectedEspecialidad = value;
                    });
                    _applyFilter(value!);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _applyFilter(String especialidad) {
    if (especialidad == 'Todas') {
      setState(() {
        _filteredDoctors = _originalDoctors;
      });
    } else {
      List<Doctor> filteredDoctors = _originalDoctors
          .where((doctor) => doctor.especialidades.contains(especialidad))
          .toList();
      setState(() {
        _filteredDoctors = filteredDoctors;
      });
    }
  }
}
