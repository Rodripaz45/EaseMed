// ignore_for_file: avoid_print, avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html';
import 'doctor.dart';

class ApiService {
  Future<void> login(String email, String password) async {
    try {
      var url = 'http://localhost:3000/paciente/login';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'email': email,
        'password': password,
      });

      print('Enviando solicitud HTTP...');

      var response = await HttpRequest.request(url,
          method: 'POST', requestHeaders: headers, sendData: body);

      print('Solicitud completada con éxito.');

      if (response.status == 200) {
        // Verificar si la solicitud fue exitosa (código de estado 200)
        print('Código de estado 200 - Éxito:');
        print(response.responseText);
        // Aquí puedes procesar el cuerpo de la respuesta según necesites
      } else {
        if (response.status == 404) {
          // Credenciales inválidas
          print('Error en la respuesta: Credenciales inválidas');
        } else {
          // Otro código de estado, manejar según sea necesario
          print('Error en la respuesta:');
          print('Código de estado: ${response.status}');
          print('Mensaje: ${response.statusText}');
        }
      }
    } catch (e) {
      print('Error en la solicitud:');
      print(e);
    }
  }

  Future<void> register(
      String email,
      String password,
      String nombre,
      String apellido,
      String fechaNacimiento,
      String documentoIdentidad,
      String telefono,
      String direccion) async {
    try {
      var url = 'http://localhost:3000/paciente/register';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'email': email,
        'password': password,
        'nombre': nombre,
        'apellido': apellido,
        'fecha_nacimiento': fechaNacimiento,
        'documento_identidad': documentoIdentidad,
        'telefono': telefono,
        'direccion': direccion,
      });

      print('Enviando solicitud HTTP...');

      var response = await HttpRequest.request(url,
          method: 'POST', requestHeaders: headers, sendData: body);

      print('Solicitud completada con éxito.');

      if (response.status == 200) {
        // Verificar si la solicitud fue exitosa (código de estado 200)
        print('Código de estado 200 - Éxito:');
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

  Future<void> createCita(
      String idMedico, String idPaciente, String fecha, String hora) async {
    try {
      var url = 'http://localhost:3000/cita/create';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'id_medico': idMedico,
        'id_paciente': idPaciente,
        'fecha': fecha,
        'hora': hora,
      });

      print('Enviando solicitud HTTP...');

      var response = await HttpRequest.request(url,
          method: 'POST', requestHeaders: headers, sendData: body);

      print('Solicitud completada con éxito.');

      if (response.status == 201) {
        // Verificar si la solicitud fue exitosa (código de estado 201 - Created)
        print('Código de estado 201 - Cita creada:');
        print(response.responseText);
        // Aquí puedes procesar el cuerpo de la respuesta según necesites
      } else if (response.status == 400) {
        // Manejar el caso de error 400 (Bad Request)
        print('Error en la solicitud:');
        print('Código de estado: ${response.status}');
        print('Mensaje: ${response.responseText}');
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
}
