import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for historical events or activities
    final List<Map<String, String>> historyItems = [
      {
        'title': 'Tournament A - Registration',
        'date': '2023-12-10',
        'description': 'You registered for Tournament A'
      },
      {
        'title': 'Tournament B - Victory',
        'date': '2023-11-05',
        'description': 'You won Tournament B and received a prize.'
      },
      {
        'title': 'Tournament C - Registration',
        'date': '2023-10-20',
        'description': 'You registered for Tournament C.'
      },
      {
        'title': 'Tournament D - Participation',
        'date': '2023-09-15',
        'description': 'You participated in Tournament D but did not win.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: const Color(0xFF990000), // Match the dashboard theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: historyItems.length,
          itemBuilder: (context, index) {
            final item = historyItems[index];
            return _buildHistoryItem(context, item);
          },
        ),
      ),
    );
  }

  /// Reusable method to build each history item in the list
  Widget _buildHistoryItem(BuildContext context, Map<String, String> item) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          item['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['date'] ?? '',
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(item['description'] ?? ''),
          ],
        ),
        trailing: Icon(
          Icons.history,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
