// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediease/classes/doctor.dart';
import 'package:mediease/selectHour.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDate extends StatefulWidget {
  final Doctor doctor;

  const SelectDate({required this.doctor});

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turnos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.doctor.especialidades.join(" | ")} | ${widget.doctor.nombres} ${widget.doctor.apellidos}',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Elegí día y horario',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              enabledDayPredicate: (day) {
                // Solo permite seleccionar días desde hoy en adelante
                return day.isAfter(DateTime.now().subtract(Duration(days: 1)));
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(height: 16.0),
            // Aquí podrías añadir un selector de horarios
            ElevatedButton(
              onPressed: () {
                String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectHour(fecha: formattedDate, doctor: widget.doctor,)),
                        );
              },
              child: Text('Reservar Cita'),
            ),
          ],
        ),
      ),
    );
  }
}
