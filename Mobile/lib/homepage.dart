import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/cards/password_dialog.dart';
import 'package:mediease/classes/doctor.dart';
import 'package:mediease/doctor_profilepage.dart';
import 'package:intl/intl.dart';
import 'package:mediease/profile_page.dart';
import 'package:mediease/reservas_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final ApiService _apiService = ApiService();

  Doctor? _selectedDoctor;
  List<Doctor> _doctors = [];
  List<String>? _selectedDoctorHours;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      _dateController.text = formattedDate;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
    _selectedDoctorHours = _selectedDoctor?.horasTrabajo ?? [];
  }

  Future<void> _fetchDoctors() async {
    try {
      List<Doctor> fetchedDoctors = await _apiService.getMedicos();
      setState(() {
        _doctors = fetchedDoctors;
      });
    } catch (e) {
      print('Error al obtener los médicos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi App Médica'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '¡Haz tu Reserva!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<Doctor>(
                value: _selectedDoctor,
                onChanged: (Doctor? newValue) {
                  setState(() {
                    _selectedDoctor = newValue;
                    _selectedDoctorHours = _selectedDoctor?.horasTrabajo;
                  });
                },
                items: _doctors.map<DropdownMenuItem<Doctor>>((Doctor doctor) {
                  return DropdownMenuItem<Doctor>(
                    value: doctor,
                    child: Text('${doctor.nombres} ${doctor.apellidos}'),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Doctor',
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () => _selectDate(context),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedDoctorHours != null && _selectedDoctorHours!.isNotEmpty ? _selectedDoctorHours![0] : null,
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) {
                      _selectedDoctorHours = [newValue];
                    }
                  });
                },
                items: _selectedDoctorHours != null && _selectedDoctorHours!.isNotEmpty
                    ? _selectedDoctorHours!
                        .map<DropdownMenuItem<String>>((String hour) {
                          return DropdownMenuItem<String>(
                            value: hour,
                            child: Text(hour),
                          );
                        }).toList()
                    : [],
                decoration: InputDecoration(
                  labelText: 'Horas de Trabajo',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  int? idPaciente = prefs.getInt('userId');
                  if (_selectedDoctor == null || idPaciente == null) {
                    print('Por favor, seleccione un doctor o verifique el ID del paciente.');
                    return;
                  }
                  await _apiService.createCita(
                    _selectedDoctor!.id.toString(),
                    idPaciente.toString(),
                    _dateController.text,
                    _selectedDoctorHours![0],
                  );
                  _nameController.clear();
                  _dateController.clear();
                  _timeController.clear();
                },
                child: Text('Reservar'),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/new_logo_small.jpg',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Doctores Disponibles'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorProfile()),
                );
              },
            ),
            ListTile(
              title: Text('Tus Reservas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReservasPage()),
                );
              },
            ),
            ListTile(
              title: Text('Tu Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Tu Historial Medico'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => PasswordDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
