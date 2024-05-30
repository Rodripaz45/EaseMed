import 'package:flutter/material.dart';
import 'package:mediease/api_service.dart';
import 'package:mediease/cards/reserve_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({Key? key}) : super(key: key);

  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  int idPaciente = 0; // Initialize with default value
  List<Reserva> reservas = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserId(); // Fetch patient ID from SharedPreferences
  }

  Future<void> _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userId')) {
      setState(() {
        idPaciente = prefs.getInt('userId')!;
      });
      _fetchReservas(); // Fetch reservations after obtaining ID
    } else {
      // Handle the case where 'userId' is not stored in SharedPreferences
      print('User ID not found in SharedPreferences');
    }
  }

  Future<void> _fetchReservas() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });
    try {
      final fetchedReservas = await ApiService.getReservas(idPaciente);
      setState(() {
        reservas = fetchedReservas;
        isLoading = false; // Set loading state to false
      });
    } catch (e) {
      // Handle errors appropriately (e.g., display error message)
      print('Error fetching reservations: $e');
      // Consider showing a snackbar or dialog to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas'),
        backgroundColor: Colors.blue, // Color azul para el AppBar
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : reservas.isNotEmpty
                ? Column(
                    children: [
                      Text(
                        'Tus Reservas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Display the list of reservations using ListView.builder
                      Expanded( // Wrap ListView.builder with Expanded
                        child: ListView.builder(
                          shrinkWrap: true, // Prevent list view from expanding
                          itemCount: reservas.length,
                          itemBuilder: (context, index) {
                            return ReservaCard(reserva: reservas[index]);
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'No tienes reservas aún',
                      style: TextStyle(fontSize: 14), // Adjust font size as needed
                    ),
                  ),
      ),
    );
  }
}
