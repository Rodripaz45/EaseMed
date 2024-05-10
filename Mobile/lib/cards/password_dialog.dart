import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/consultas_page.dart';
import 'package:mediease/login_page.dart';

class PasswordDialog extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ingresa tu contraseña'),
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Contraseña',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
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
                  content: Text('Contraseña incorrecta'),
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
