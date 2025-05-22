import 'package:flutter/material.dart';

class ConductorDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String name = args?['name'] ?? 'Condutor';
    final String id = args?['id'] ?? '';
    final String photoUrl = args?['photoUrl'] ?? '';

    // Mock de avaliações
    final List<Map<String, dynamic>> reviews = [
      {
        'user': 'João',
        'rating': 5.0,
        'comment': 'Excelente condutor, muito atencioso!'
      },
      {
        'user': 'Maria',
        'rating': 4.5,
        'comment': 'Passeio seguro e agradável.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Condutor: $name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (photoUrl.isNotEmpty)
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(photoUrl),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Avaliações:', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...reviews.map((r) => Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(r['user']),
                subtitle: Text(r['comment']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(r['rating'].toString()),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
} 