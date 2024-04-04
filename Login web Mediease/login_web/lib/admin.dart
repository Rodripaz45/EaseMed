
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_web/api_service.dart';
 
class PostMedicoPage extends StatefulWidget {
  @override
  _PostMedicoPageState createState() => _PostMedicoPageState();
}
 
class _PostMedicoPageState extends State<PostMedicoPage> {
  final ApiService apiService = ApiService();
 
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
              Text(
                'Especialidades:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildAutocompleteTextField(),
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
 
  Widget _buildAutocompleteTextField() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
       
        return _especialidades.where((String option) {
          return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
        });
      },
      onSelected: (String selectedOption) {
       
        setState(() {
          _selectedEspecialidades.add(selectedOption);
        });
      },
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
     
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: (String value) {
           
            _updateAutocompleteOptions(value);
          },
          decoration: InputDecoration(
            hintText: 'Ingrese una especialidad',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                textEditingController.clear();
                _updateAutocompleteOptions('');
              },
            ),
          ),
          onSubmitted: (String value) {
         
            if (value.isNotEmpty) {
              _selectedEspecialidades.add(value);
              textEditingController.clear();
            }
          },
        );
      },
    );
  }
 
  void _updateAutocompleteOptions(String value) {
   
    setState(() {});
  }
 
  void _addMedico() async {
    String nombres = _nameController.text;
    String apellidos = _lastNameController.text;
    List<String> especialidades = _selectedEspecialidades;
    String descripcion = _descriptionController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
 
 
    await apiService.createMedico(
      nombres,
      apellidos,
      especialidades,
      descripcion,
      username,
      password,
    );
 
 
    Fluttertoast.showToast(
      msg: 'Médico creado correctamente',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
 
    Navigator.pop(context);
  }
}
 
 