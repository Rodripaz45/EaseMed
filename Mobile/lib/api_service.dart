// ignore_for_file: avoid_print, avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html';
import 'package:mediease/cards/reserve_card.dart';
import 'package:mediease/classes/consulta.dart';
import 'package:mediease/classes/paciente.dart';
import 'package:mediease/classes/qr.dart';
import 'classes/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
Future<int?> login(String email, String password) async {
  try {
    var url = 'https://easemedapi.onrender.com/paciente/login';
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
      print('Código de estado 200 - Éxito:');

      if (response.responseText != null) {
        try {
          var jsonResponse = jsonDecode(response.responseText!);
          var userId = jsonResponse['id'] as int?;

          if (userId != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('userId', userId);
            print(
                'ID de usuario guardado en las preferencias compartidas: $userId');
          } else {
            print('Error: ID de usuario nulo en la respuesta JSON');
          }

          // Aquí puedes procesar el cuerpo de la respuesta según necesites
        } catch (e) {
          print('Error al decodificar la respuesta JSON: $e');
        }
      } else {
        print('La respuesta está vacía');
      }
    } else {
      print('Error en la respuesta:');
      print('Código de estado: ${response.status}');
      print('Mensaje: ${response.statusText}');

      if (response.status == 404) {
        // Credenciales inválidas
        print('Error en la respuesta: Credenciales inválidas');
      }
    }

    // Devolver el response status
    return response.status;
  } catch (e) {
    print('Error en la solicitud:');
    print(e);
    return null; // En caso de error, devolver null
  }
}

Future<int?> register(
      String email,
      String password,
      String nombre,
      String apellido,
      String fechaNacimiento,
      String documentoIdentidad,
      String telefono,
      String direccion) async {
    try {
      var url = 'https://easemedapi.onrender.com/paciente/register';
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
        print('Código de estado 200 - Éxito:');

        if (response.responseText != null) {
          try {
            var jsonResponse = jsonDecode(response.responseText!);
            var userId = jsonResponse['id'] as int?;

            if (userId != null) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt('userId', userId);
              print(
                  'ID de usuario guardado en las preferencias compartidas: $userId');
            } else {
              print('Error: ID de usuario nulo en la respuesta JSON');
            }

            // Aquí puedes procesar el cuerpo de la respuesta según necesites
          } catch (e) {
            print('Error al decodificar la respuesta JSON: $e');
          }
        } else {
          print('La respuesta está vacía');
        }
      } else {
        print('Error en la respuesta:');
        print('Código de estado: ${response.status}');
        print('Mensaje: ${response.statusText}');

        if (response.status == 404) {
          // Credenciales inválidas
          print('Error en la respuesta: Credenciales inválidas');
        }
      }
      return response.status; // Devuelve el response status
    } catch (e) {
      print('Error en la solicitud:');
      print(e);
      return null; // En caso de error, devolver null
    }
}

  Future<void> createCita(
      String idMedico, String idPaciente, String fecha, String hora) async {
    try {
      var url = 'https://easemedapi.onrender.com/cita/create';
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
      var url = 'https://easemedapi.onrender.com/medico';
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

  static Future<List<Reserva>> getReservas(int idPaciente) async {
    try {
      final url = 'https://easemedapi.onrender.com/cita/paciente?id_paciente=$idPaciente';
      final headers = {'Content-Type': 'application/json'};

      final response = await HttpRequest.request(
        url,
        method: 'GET',
        requestHeaders: headers,
      );

      if (response.status == 200) {
        if (response.responseText != null) {
          final jsonResponse =
              jsonDecode(response.responseText!) as List<dynamic>;
          final reservas =
              jsonResponse.map((reserva) => Reserva.fromJson(reserva)).toList();
          return reservas;
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
 
 Future<Paciente> getPacienteById(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');

      if (userId == null) {
        throw Exception('ID de usuario no encontrado en las preferencias compartidas');
      }

      var url = 'https://easemedapi.onrender.com/paciente/getById?id=$userId';
      var headers = {'Content-Type': 'application/json'};

      var response = await HttpRequest.request(url,
          method: 'GET', requestHeaders: headers);

      if (response.status == 200) {
        if (response.responseText != null) {
          Map<String, dynamic> jsonResponse = jsonDecode(response.responseText!);

          return Paciente.fromJson(jsonResponse);
        } else {
          throw Exception('La respuesta está vacía');
        }
      } else {
        throw Exception('Error en la respuesta: ${response.statusText}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }

  Future<List<Consulta>> getConsultasById(int id) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId == null) {
      throw Exception('ID de usuario no encontrado en las preferencias compartidas');
    }

    var url = 'https://easemedapi.onrender.com/getConsultasById?id=$userId';
    var headers = {'Content-Type': 'application/json'};

    var response = await HttpRequest.request(url,
        method: 'GET', requestHeaders: headers);

    if (response.status == 200) {
      if (response.responseText != null) {
        List<dynamic> jsonResponse = jsonDecode(response.responseText!);

        // Mapear la lista de consultas JSON a objetos Consulta
        List<Consulta> consultas = jsonResponse.map((data) => Consulta.fromJson(data)).toList();

        return consultas;
      } else {
        throw Exception('La respuesta está vacía');
      }
    } else {
      throw Exception('Error en la respuesta: ${response.statusText}');
    }
  } catch (e) {
    throw Exception('Error en la solicitud GET: $e');
  }
}

 Future<QR> generarQR(String numeroPago) async {
    try {
      var url = 'https://serviciostigomoney.pagofacil.com.bo/api/servicio/generarqrv2';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        "tcCommerceID": "d029fa3a95e174a19934857f535eb9427d967218a36ea014b70ad704bc6c8d1c",
        "tnMoneda": 1,
        "tnTelefono": 70986514,
        "tcCorreo": "rodripaz45@gmail.com",
        "tcNombreUsuario": "JUANITO PEREZ",
        "tnCiNit": 123455,
        "tcNroPago": numeroPago,
        "tnMontoClienteEmpresa": 0.01,
        "tcUrlCallBack": "https://easemedapi.onrender.com/callback",
        "tcUrlReturn": "",
        "taPedidoDetalle": {
          "serial": 1,
          "producto": "PRODUCTO 1",
          "cantidad": 2,
          "precio": 10,
          "descuento": 10,
          "total": 2
        }
      });

      var response = await HttpRequest.request(
        url,
        method: 'POST',
        requestHeaders: headers,
        sendData: body,
      );

      if (response.status == 200) {
        // Si la respuesta es exitosa, devuelve un objeto QR
        Map<String, dynamic> jsonResponse = jsonDecode(response.responseText!);
        return QR.fromJson(jsonResponse);
      } else {
        throw Exception('Error en la respuesta: ${response.statusText}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud POST: $e');
    }
  }}
