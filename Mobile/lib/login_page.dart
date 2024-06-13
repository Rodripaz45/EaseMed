import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/homepage.dart';
import 'package:mediease/register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Med Ease'),
        backgroundColor: Color(0xFF774568), // Color morado oscuro
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_morado.png',
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
          labelStyle: TextStyle(color: Color(0xFF774568)), // Texto morado oscuro
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        cursorColor: Color(0xFF774568), // Cursor morado oscuro
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Color(0xFF774568),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
                ),
                title: Text('Error', style: TextStyle(color: Colors.black)), // Texto negro
                content: Text('Credenciales incorrectas. Por favor, inténtalo de nuevo.', style: TextStyle(color: Colors.black)), // Texto negro
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK', style: TextStyle(color: Color(0xFF774568))), // Texto morado oscuro
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
            color: Color(0xFF774568), // Color morado oscuro
          ),
        ),
        IconButton(
          onPressed: () {
            // Iniciar sesión con correo electrónico
          },
          iconSize: 50,
          icon: Icon(
            Icons.email,
            color: Color(0xFF774568), // Color morado oscuro
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
          color: Color(0xFF774568), // Color morado oscuro
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
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Color(0xFF774568),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
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
