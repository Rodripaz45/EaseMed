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
        title: Text('CENTRO MÉDICO LH'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset('assets/new_logo_small.jpg'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a la pantalla de solicitud de turno
                    },
                    child: Text('Solicitar turno'),
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _buildCard('Tus Reservas', Icons.event, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReservasPage()),
                        );
                      }),
                      _buildCard('Tu Perfil', Icons.person, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                        );
                      }),
                      _buildCard('Tu Historial Medico', Icons.history, () {
                        showDialog(
                          context: context,
                          builder: (context) => PasswordDialog(),
                        );
                      }),
                      _buildCard('Nuestros Doctores', Icons.local_hospital, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DoctorProfile()),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
                    'Med Ease',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/new_logo_small.jpg',
                    width: 100,
                    height: 80,
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

  Widget _buildCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 50, color: Colors.blue),
              SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
