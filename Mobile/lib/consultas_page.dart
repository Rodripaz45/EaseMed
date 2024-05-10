import 'package:flutter/material.dart';
import 'package:mediease/cards/consulta_card.dart';
import 'package:mediease/classes/consulta.dart';
import 'package:mediease/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultasPage extends StatefulWidget {
  @override
  _ConsultasPageState createState() => _ConsultasPageState();
}

class _ConsultasPageState extends State<ConsultasPage> {
  List<Consulta> consultas = []; // Inicializamos consultas como una lista vacía

  @override
  void initState() {
    super.initState();
    loadConsultas();
  }

  Future<void> loadConsultas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');
      if (userId == null) {
        throw Exception('ID de usuario no encontrado en las preferencias compartidas');
      }

      // Aquí cargamos las consultas utilizando el método getConsultasById del ApiService
      List<Consulta> consultasLoaded = await ApiService().getConsultasById(userId);
      
      setState(() {
        consultas = consultasLoaded; // Actualizamos consultas con los datos cargados
      });
    } catch (e) {
      // Manejar errores al cargar las consultas
      print('Error al cargar consultas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Consultas'),
      ),
      body: consultas.isNotEmpty
          ? ListView.builder(
              itemCount: consultas.length,
              itemBuilder: (context, index) {
                return ConsultaCard(consulta: consultas[index]);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
