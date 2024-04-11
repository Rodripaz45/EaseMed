import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart'; 
import 'package:login_web/doctor.dart';
import 'package:login_web/doctor_card.dart';
import 'package:login_web/detallesdoctor.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late List<Doctor> doctors = [];

  final ApiService apiService = ApiService(); 

  @override
  void initState() {
    super.initState();
    
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
    
      List<Doctor> fetchedDoctors = await apiService.getMedicos();

      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (e) {
    
      print('Error al obtener los médicos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctores Registrados'),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.2, 
        mainAxisSpacing: 8.0, 
        crossAxisSpacing: 8.0, 
        padding: EdgeInsets.all(8.0), 
        children: doctors.map((doctor) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsScreen(doctor: doctor),
                ),
              );
            },
            child: DoctorCard(doctor: doctor),
          );
        }).toList(),
      ),
    );
  }
}

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  DoctorDetailsScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Doctor'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                'https://t3.ftcdn.net/jpg/02/48/87/00/360_F_248870078_Wuf8dA4IVf1SB8aH9Ah0HMNYOCNun479.jpg',
                fit: BoxFit.contain, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${doctor.nombres}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Especialidad: ${doctor.especialidades}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Experiencia: ${doctor.descripcion} años',
                  style: TextStyle(fontSize: 18),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}




