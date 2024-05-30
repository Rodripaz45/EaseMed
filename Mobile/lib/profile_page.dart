import 'package:flutter/material.dart';
import 'package:mediease/cards/profile_card.dart'; // Importa tu tarjeta de paciente

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del Paciente'),
      ),
      body: PacienteCard(), 
    );
  }
}

