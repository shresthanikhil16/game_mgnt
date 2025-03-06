import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/history/presentation/view_model/history_bloc.dart';
import 'package:game_mgnt/features/history/presentation/view_model/history_event.dart';
import 'package:game_mgnt/features/history/presentation/view_model/history_state.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(FetchWinners());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF990000),
      ),
      body: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryError && state.message.contains('No internet')) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No internet connection')),
            );
          }
        },
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.winners.length,
                itemBuilder: (context, index) {
                  final item = state.winners[index];
                  return _buildHistoryItem(context, item);
                },
              ),
            );
          } else if (state is HistoryError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Initial state'));
          }
        },
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, item) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          item.tournament,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.date.toString(),
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(item.winner),
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
