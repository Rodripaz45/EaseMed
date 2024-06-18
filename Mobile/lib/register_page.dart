// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mediease/api_service.dart';
import 'package:mediease/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedEase Register',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Utilizamos un color morado oscuro como tema principal
        scaffoldBackgroundColor: Colors.white, // Fondo blanco
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Med Ease Register',
        ),
        backgroundColor: Color(0xFF774568), // Color morado oscuro
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _documentoIdentidadController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fechaNacimientoController.text = picked.toString(); // Puedes cambiar el formato aquí según tus necesidades
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Instancia ApiService
      ApiService apiService = ApiService();

      // Obtén los valores de los campos del formulario
      String email = _emailController.text;
      String password = _passwordController.text;
      String nombre = _nombreController.text;
      String apellido = _apellidoController.text;
      String fechaNacimiento = _fechaNacimientoController.text;
      String documentoIdentidad = _documentoIdentidadController.text;
      String telefono = _telefonoController.text;
      String direccion = _direccionController.text;

      // Llama al método register de ApiService con los datos del formulario
      apiService.register(
        email,
        password,
        nombre,
        apellido,
        fechaNacimiento,
        documentoIdentidad,
        telefono,
        direccion,
      ).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),);
        print('Registro completado con éxito');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email, color: Color(0xFF774568)), // Icono morado oscuro
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock, color: Color(0xFF774568)), // Icono morado oscuro
            ),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _nombreController,
            decoration: InputDecoration(
              labelText: 'Nombre',
              prefixIcon: Icon(Icons.person, color: Color(0xFF774568)), // Icono morado oscuro
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _apellidoController,
            decoration: InputDecoration(
              labelText: 'Apellido',
              prefixIcon: Icon(Icons.person, color: Color(0xFF774568)), // Icono morado oscuro
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu apellido';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () => _selectDate(context),
            child: TextFormField(
              controller: _fechaNacimientoController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento',
                prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF774568)), // Icono morado oscuro
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa tu fecha de nacimiento';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _documentoIdentidadController,
            decoration: InputDecoration(
              labelText: 'Documento de Identidad',
              prefixIcon: Icon(Icons.assignment, color: Color(0xFF774568)), // Icono morado oscuro
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu documento de identidad';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _telefonoController,
            decoration: InputDecoration(
              labelText: 'Teléfono',
              prefixIcon: Icon(Icons.phone, color: Color(0xFF774568)), // Icono morado oscuro
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu número de teléfono';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _direccionController,
            decoration: InputDecoration(
              labelText: 'Dirección',
              prefixIcon: Icon(Icons.location_on, color: Color(0xFF774568)), // Icono morado oscuro
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu dirección';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text(
                'REGISTRARSE',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF774568)), // Fondo morado oscuro
              ),
            ),
          ),
        ],
      ),
    );
  }
}
