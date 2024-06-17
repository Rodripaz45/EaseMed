import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/classes/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectHour extends StatefulWidget {
  final String fecha;
  final Doctor doctor;

  const SelectHour({required this.fecha, required this.doctor});

  @override
  _SelectHourState createState() => _SelectHourState();
}

class _SelectHourState extends State<SelectHour> {
  int? userId;
  DateTime? userDob;
  bool? isOlderThan65;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
      String? dobString = prefs.getString(
          'userDob'); // Asegúrate de tener la fecha de nacimiento almacenada
      if (dobString != null) {
        userDob = DateTime.parse(dobString);
        isOlderThan65 = _isPatientOlderThan65();
        print(
            '¿Paciente mayor de 65 años?: ${isOlderThan65 == true ? "Sí" : "No"}');
      } else {
        print("no hay user");
      }
    });
  }

  bool _isPatientOlderThan65() {
    if (userDob == null) return false;
    DateTime today = DateTime.now();
    int age = today.year - userDob!.year;
    if (today.month < userDob!.month ||
        (today.month == userDob!.month && today.day < userDob!.day)) {
      age--;
    }
    bool isOlder = age >= 65;
    print('Edad del paciente: $age, ¿Es mayor de 65?: $isOlder');
    return isOlder;
  }

  void _showConfirmationDialog(BuildContext context, String hora) async {
    ApiService apiService = ApiService();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
                color: Color(0xFF774568), width: 2.0), // Borde morado oscuro
          ),
          title: Text('Confirmar Cita',
              style: TextStyle(color: Colors.black)), // Texto negro
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID del Médico: ${widget.doctor.id}',
                  style: TextStyle(color: Colors.black)), // Texto negro
              Text(
                  'Nombre: ${widget.doctor.nombres} ${widget.doctor.apellidos}',
                  style: TextStyle(color: Colors.black)), // Texto negro
              Text('Especialidad: ${widget.doctor.especialidades.join(", ")}',
                  style: TextStyle(color: Colors.black)), // Texto negro
              Text('Fecha: ${widget.fecha}',
                  style: TextStyle(color: Colors.black)), // Texto negro
              Text('Hora: $hora',
                  style: TextStyle(color: Colors.black)), // Texto negro
              Text(
                  'Antes de tu cita debes presentarte con tu documento de identidad en mostrador',
                  style: TextStyle(color: Colors.red)), // Texto negro
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF774568), // Fondo morado oscuro
                foregroundColor: Colors.white, // Texto blanco
              ),
              onPressed: () async {
                int responseStatus = await apiService.createCita(
                  widget.doctor.id.toString(),
                  userId.toString(),
                  widget.fecha,
                  hora,
                );

                if (responseStatus == 201) {
                  Fluttertoast.showToast(
                    msg: "Cita creada con éxito",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  for (int i = 0; i < 4; i++) {
                    Navigator.of(context).pop();
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: "Error al crear la cita",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: Text('Confirmar Cita'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableHours = widget.doctor.horasTrabajo;
    if (isOlderThan65 == false) {
      availableHours = availableHours.sublist(4);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Turnos'),
        backgroundColor: Color(0xFF774568), // Color morado oscuro
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Ícono morado oscuro
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFF774568),
                    width: 2.0), // Borde morado oscuro
                borderRadius:
                    BorderRadius.circular(8.0), // Bordes redondeados opcional
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${widget.doctor.especialidades.join(" | ")} | ${widget.doctor.nombres} ${widget.doctor.apellidos}',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black), // Texto negro
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Elegí día y horario',
              style:
                  TextStyle(fontSize: 18.0, color: Colors.black), // Texto negro
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                '${_formatFecha(widget.fecha)}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF774568)), // Texto morado oscuro
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 2.5,
                ),
                itemCount: availableHours.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Color(0xFF774568), // Fondo morado oscuro
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // Mostrar cuadro de diálogo de confirmación
                        _showConfirmationDialog(context, availableHours[index]);
                      },
                      child: Text(availableHours[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatFecha(String fecha) {
    DateTime parsedDate = DateTime.parse(fecha);
    return '${_getWeekday(parsedDate.weekday)} ${parsedDate.day} - ${_getMonth(parsedDate.month)} ${parsedDate.year}';
  }

  String _getWeekday(int weekday) {
    const List<String> weekdays = [
      'LUNES',
      'MARTES',
      'MIÉRCOLES',
      'JUEVES',
      'VIERNES',
      'SÁBADO',
      'DOMINGO'
    ];
    return weekdays[weekday - 1];
  }

  String _getMonth(int month) {
    const List<String> months = [
      'ENERO',
      'FEBRERO',
      'MARZO',
      'ABRIL',
      'MAYO',
      'JUNIO',
      'JULIO',
      'AGOSTO',
      'SEPTIEMBRE',
      'OCTUBRE',
      'NOVIEMBRE',
      'DICIEMBRE'
    ];
    return months[month - 1];
  }
}
