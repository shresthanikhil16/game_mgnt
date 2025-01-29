import 'package:flutter/material.dart';

class RegisteredView extends StatelessWidget {
  const RegisteredView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of tournaments that the user has registered for
    final List<Map<String, String>> registeredTournaments = [
      {
        'title': 'Tournament A',
        'registrationDate': '2023-12-10',
        'tournamentDate': '2023-12-20',
        'status': 'Registered'
      },
      {
        'title': 'Tournament B',
        'registrationDate': '2023-11-05',
        'tournamentDate': '2023-11-15',
        'status': 'Completed'
      },
      {
        'title': 'Tournament C',
        'registrationDate': '2023-10-20',
        'tournamentDate': '2023-10-25',
        'status': 'Registered'
      },
      {
        'title': 'Tournament D',
        'registrationDate': '2023-09-15',
        'tournamentDate': '2023-09-18',
        'status': 'Cancelled'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Tournaments'),
        backgroundColor: const Color(0xFF990000), // Match the dashboard theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: registeredTournaments.length,
          itemBuilder: (context, index) {
            final tournament = registeredTournaments[index];
            return _buildTournamentItem(context, tournament);
          },
        ),
      ),
    );
  }

  /// Reusable method to build each tournament item in the list
  Widget _buildTournamentItem(
      BuildContext context, Map<String, String> tournament) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          tournament['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registered: ${tournament['registrationDate']}',
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            Text(
              'Tournament Date: ${tournament['tournamentDate']}',
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text('Status: ${tournament['status']}'),
          ],
        ),
        trailing: Icon(
          Icons.event,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
