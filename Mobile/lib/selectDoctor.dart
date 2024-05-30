import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/classes/doctor.dart';
import 'package:mediease/cards/doctor_card.dart';

class Especialidad {
  String nombre;
  bool seleccionada;

  Especialidad(this.nombre, this.seleccionada);
}

class SelectDoctor extends StatefulWidget {
  @override
  _SelectDoctorState createState() => _SelectDoctorState();
}

class _SelectDoctorState extends State<SelectDoctor> {
  late List<Doctor> _originalDoctors = [];
  late List<Doctor> _filteredDoctors = [];
  final ApiService apiService = ApiService();
  List<Especialidad> _especialidades = [
    Especialidad('Alergología', false),
    Especialidad('Anestesiología', false),
    Especialidad('Cardiología', false),
    Especialidad('Cirugía', false),
    Especialidad('Dermatología', false),
    Especialidad('Endocrinología', false),
    Especialidad('Gastroenterología', false),
    Especialidad('Geriatría', false),
    Especialidad('Ginecología', false),
    Especialidad('Hematología', false),
    Especialidad('Infectología', false),
    Especialidad('Medicina de emergencia', false),
    Especialidad('Medicina deportiva', false),
    Especialidad('Medicina familiar', false),
    Especialidad('Medicina interna', false),
    Especialidad('Nefrología', false),
    Especialidad('Neumología', false),
    Especialidad('Neurología', false),
    Especialidad('Obstetricia', false),
    Especialidad('Oncología', false),
    Especialidad('Oftalmología', false),
    Especialidad('Ortopedia', false),
    Especialidad('Otorrinolaringología', false),
    Especialidad('Pediatría', false),
    Especialidad('Psiquiatría', false),
    Especialidad('Radiología', false),
    Especialidad('Reumatología', false),
    Especialidad('Traumatología', false),
    Especialidad('Urología', false),
  ];

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
        title: Text('Nuestros Doctores'),
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
          return DoctorCard(doctor: _filteredDoctors[index], canReserve: true);
        },
      ),
    );
  }

 void _showFilterOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Filtrar por especialidades'),
        content: SingleChildScrollView(
          child: Column(
            children: _especialidades.map((especialidad) {
              return CustomCheckboxListTile(
                title: especialidad.nombre,
                value: especialidad.seleccionada,
                onChanged: (value) {
                  setState(() {
                    _setCheckState(especialidad, value ?? false);
                    _applyFilter();
                  });
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cerrar'),
          ),
        ],
      );
    },
  );
}

  bool _isChecked(Especialidad especialidad) {
    return especialidad.seleccionada;
  }

  void _setCheckState(Especialidad especialidad, bool value) {
    especialidad.seleccionada = value;
  }

  void _applyFilter() {
    List<String> especialidadesSeleccionadas = _especialidades
        .where((especialidad) => especialidad.seleccionada)
        .map((especialidad) => especialidad.nombre)
        .toList();

    setState(() {
      if (especialidadesSeleccionadas.isEmpty) {
        _filteredDoctors = _originalDoctors;
      } else {
        _filteredDoctors = _originalDoctors.where((doctor) =>
            doctor.especialidades.any(
                (especialidad) => especialidadesSeleccionadas.contains(especialidad))).toList();
      }
    });
  }
}

class CustomCheckboxListTile extends StatefulWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxListTile({
    required this.title,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CustomCheckboxListTileState createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: _isChecked,
      onChanged: (value) {
        setState(() {
          _isChecked = value ?? false;
        });
        widget.onChanged(_isChecked);
      },
    );
  }
}
