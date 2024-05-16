import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/homepage.dart';
import 'package:mediease/register_page.dart'; // Importa tu archivo de dialogo de contraseña

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static String email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Med Ease'),
        backgroundColor: Colors.blueAccent, // Color actualizado
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/new_logo.ico',
                height: 200,
              ),
              SizedBox(height: 20),
              _buildTextField(emailController, 'Correo electrónico'),
              SizedBox(height: 16),
              _buildTextField(passwordController, 'Contraseña', isPassword: true),
              SizedBox(height: 16),
              _buildLoginButton(context),
              SizedBox(height: 16),
              _buildSocialLoginOptions(),
              SizedBox(height: 16),
              _buildForgotPasswordLink(),
              SizedBox(height: 16),
              _buildSignUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      onPressed: () async {
        email = emailController.text;
        String password = passwordController.text;

        ApiService apiService = ApiService();
        int? statusCode = await apiService.login(email, password);

        if (statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Credenciales incorrectas. Por favor, inténtalo de nuevo.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Text('INICIAR SESIÓN'),
    );
  }

  Widget _buildSocialLoginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // Iniciar sesión con Facebook
          },
          iconSize: 50,
          icon: Icon(
            Icons.facebook,
            color: Colors.blue[800], // Color actualizado
          ),
        ),
        IconButton(
          onPressed: () {
            // Iniciar sesión con correo electrónico
          },
          iconSize: 50,
          icon: Icon(
            Icons.email,
            color: Colors.blue[800], // Color actualizado
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordLink() {
    return TextButton(
      child: Text(
        '¿Olvidaste tu contraseña?',
        style: TextStyle(
          color: Colors.blueAccent, // Color actualizado
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        // Lógica para restablecer la contraseña
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: Text('Registrarse'),
    );
  }
}
