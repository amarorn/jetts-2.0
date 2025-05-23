import 'package:flutter/material.dart';

class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Reservas')),
      body: const Center(child: Text('Nenhuma reserva encontrada.')),
    );
  }
} 