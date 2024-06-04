import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/consultas_page.dart';
import 'package:mediease/login_page.dart';

class PasswordDialog extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
      ),
      title: Text('Ingresa tu contraseña', style: TextStyle(color: Colors.black)), // Texto negro
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          labelStyle: TextStyle(color: Colors.black), // Texto negro
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF774568)), // Borde morado oscuro cuando se enfoca
          ),
        ),
        cursorColor: Color(0xFF774568), // Cursor morado oscuro
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar', style: TextStyle(color: Color(0xFF774568))), // Texto morado oscuro
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF774568), // Fondo morado oscuro
            foregroundColor: Colors.white, // Texto blanco
          ),
          onPressed: () async {
            String email = LoginPage.email; // Obtenemos el email desde LoginPage
            int? status = await ApiService().login(email, _passwordController.text);
            if (status == 200) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConsultasPage()),
              );
              // Navega a la siguiente página después de iniciar sesión
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contraseña incorrecta', style: TextStyle(color: Colors.white)), // Texto blanco
                  backgroundColor: Color(0xFF774568), // Fondo morado oscuro
                ),
              );
            }
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
