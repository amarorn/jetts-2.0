import 'package:flutter/material.dart';
import '../../../domain/models/boat_model.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock de reservas
    final List<BoatModel> bookings = [
      BoatModel(
        id: '1',
        name: 'Barco de Luxo',
        location: 'Rio de Janeiro, RJ',
        price: 1500.0,
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
        features: ['Luxo', 'Piscina', 'Jacuzzi'],
        status: 'Confirmado',
        date: '15/05/2024',
      ),
      BoatModel(
        id: '2',
        name: 'Iate Moderno',
        location: 'São Paulo, SP',
        price: 2000.0,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=800&q=80',
        features: ['Moderno', 'Bar', 'Churrasqueira'],
        status: 'Pendente',
        date: '20/05/2024',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Reservas'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return GestureDetector(
            onTap: () {
              // Navegar para detalhes da reserva (opcional)
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      booking.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking.location,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                booking.status ?? 'Sem status',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              booking.date ?? '',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'R\$ ${booking.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 