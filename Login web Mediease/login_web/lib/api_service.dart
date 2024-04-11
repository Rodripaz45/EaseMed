import 'dart:convert';
import 'dart:html';

import 'package:login_web/doctor.dart';
import 'package:login_web/cita.dart'; // Asegúrate de importar la clase Cita si existe

class ApiService {
  Future<void> createMedico(
      String nombres,
      String apellidos,
      List<String> especialidades,
      String descripcion,
      String username,
      String password) async {
    try {
      var url = 'http://localhost:3000/medico/create';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'nombres': nombres,
        'apellidos': apellidos,
        'especialidades': especialidades,
        'descripcion': descripcion,
        'username': username,
        'password': password,
      });

      print('Enviando solicitud HTTP...');

      var response = await HttpRequest.request(url,
          method: 'POST', requestHeaders: headers, sendData: body);

      print('Solicitud completada con éxito.');

      if (response.status == 201) {
        // Verificar si la solicitud fue exitosa (código de estado 201)
        print('Código de estado 201 - Éxito:');
        print(response.responseText);
        // Aquí puedes procesar el cuerpo de la respuesta según necesites
      } else {
        // Manejar otros códigos de estado según sea necesario
        print('Error en la respuesta:');
        print('Código de estado: ${response.status}');
        print('Mensaje: ${response.statusText}');
      }
    } catch (e) {
      print('Error en la solicitud:');
      print(e);
    }
  }

  Future<List<Doctor>> getMedicos() async {
    try {
      var url = 'http://localhost:3000/medico';
      var headers = {'Content-Type': 'application/json'};

      var response = await HttpRequest.request(url,
          method: 'GET', requestHeaders: headers);

      if (response.status == 200) {
        // Verificar que response.responseText no sea nulo
        if (response.responseText != null) {
          // Decodificar la respuesta JSON a una lista de mapas
          List<dynamic> jsonResponse = jsonDecode(response.responseText!);

          // Convertir cada mapa en un objeto Doctor y almacenarlo en una lista
          List<Doctor> doctors =
              jsonResponse.map((json) => Doctor.fromJson(json)).toList();

          return doctors;
        } else {
          throw Exception('La respuesta está vacía');
        }
      } else {
        throw Exception('Error en la respuesta');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }

  // Método para obtener la lista de citas desde la API
  Future<List<Cita>> getCitas() async {
    try {
      var url = 'http://localhost:3000/cita';
      var headers = {'Content-Type': 'application/json'};

      var response = await HttpRequest.request(url,
          method: 'GET', requestHeaders: headers);

      if (response.status == 200) {
        if (response.responseText != null) {
          List<dynamic> jsonResponse = jsonDecode(response.responseText!);
          List<Cita> citas = jsonResponse.map((json) => Cita.fromJson(json)).toList();
          return citas;
        } else {
          throw Exception('La respuesta está vacía');
        }
      } else {
        throw Exception('Error en la respuesta');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }
}
