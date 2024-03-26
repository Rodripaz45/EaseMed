// ignore_for_file: avoid_print, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';

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
  
  Future<void> register(String email, String password, String nombre, String apellido, String fechaNacimiento, String documentoIdentidad, String telefono, String direccion) async {
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
}
