import 'dart:math';

import 'package:flutter/material.dart';

class MatchupView extends StatelessWidget {
  final List<String> registeredPlayers = [
    'Player 1',
    'Player 2',
    'Player 3',
    'Player 4',
    'Player 5',
    'Player 6',
    'Player 7',
    'Player 8',
  ];

  MatchupView({super.key});

  @override
  Widget build(BuildContext context) {
    // Shuffle the players
    final shuffledPlayers = List<String>.from(registeredPlayers)
      ..shuffle(Random());

    // Pair the players
    final List<List<String>> matchups = [];
    for (int i = 0; i < shuffledPlayers.length; i += 2) {
      if (i + 1 < shuffledPlayers.length) {
        matchups.add([shuffledPlayers[i], shuffledPlayers[i + 1]]);
      } else {
        // Handle odd number of players
        matchups.add([shuffledPlayers[i], 'Bye']);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchup List'),
        backgroundColor: const Color(0xFF990000), // Match dashboard theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: matchups.length,
          itemBuilder: (context, index) {
            final matchup = matchups[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  '${matchup[0]} vs ${matchup[1]}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.sports_esports),
              ),
            );
          },
        ),
      ),
    );
  }
}
