import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_web/api_service.dart';

class PostMedicoPage extends StatefulWidget {
  @override
  _PostMedicoPageState createState() => _PostMedicoPageState();
}

class _PostMedicoPageState extends State<PostMedicoPage> {
  final ApiService apiService = ApiService(); // Instancia de ApiService

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

  List<String> _selectedEspecialidades = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Médico'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombres'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Apellidos'),
              ),
              SizedBox(height: 16),
              Text('Especialidades:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _buildEspecialidadesCheckboxes(),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nombre de usuario'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addMedico();
                },
                child: Text('Agregar Médico'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEspecialidadesCheckboxes() {
    List<Widget> checkboxes = [];
    for (String especialidad in _especialidades) {
      checkboxes.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _selectedEspecialidades.contains(especialidad),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    _selectedEspecialidades.add(especialidad);
                  } else {
                    _selectedEspecialidades.remove(especialidad);
                  }
                });
              },
            ),
            Text(especialidad),
          ],
        ),
      );
    }
    return checkboxes;
  }

  void _addMedico() async {
  String nombres = _nameController.text;
  String apellidos = _lastNameController.text;
  List<String> especialidades = _selectedEspecialidades;
  String descripcion = _descriptionController.text;
  String username = _usernameController.text;
  String password = _passwordController.text;

  // Llama al servicio API para crear el médico
  await apiService.createMedico(
      nombres, apellidos, especialidades, descripcion, username, password);

  // Muestra el toast
  Fluttertoast.showToast(
    msg: 'Médico creado correctamente',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );

  // Regresa a la pantalla anterior
  Navigator.pop(context);
}

}
