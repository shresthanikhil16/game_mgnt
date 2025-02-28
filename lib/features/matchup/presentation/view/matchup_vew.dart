// lib/features/matchup/presentation/view/matchup_vew.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/matchup/domain/entity/matchups_entity.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_bloc.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_event.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_state.dart';

class MatchupView extends StatefulWidget {
  const MatchupView({super.key});

  @override
  State<MatchupView> createState() => _MatchupViewState();
}

class _MatchupViewState extends State<MatchupView> {
  String? _selectedTournament;

  @override
  void initState() {
    super.initState();
    context.read<MatchupBloc>().add(FetchUniqueTournaments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchup List'),
        backgroundColor: const Color(0xFF990000),
      ),
      body: BlocBuilder<MatchupBloc, MatchupState>(
        builder: (context, state) {
          if (state is MatchupLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchupLoaded) {
            return _buildMatchupList(state);
          } else if (state is UniqueTournamentsLoaded) {
            return _buildTournamentDropdown(state);
          } else if (state is MatchupError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Select a tournament.'));
          }
        },
      ),
    );
  }

  Widget _buildTournamentDropdown(UniqueTournamentsLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _selectedTournament,
            items: state.tournaments
                .map((tournament) => DropdownMenuItem(
                      value: tournament,
                      child: Text(tournament),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedTournament = value;
              });
              context.read<MatchupBloc>().add(FetchMatchups(value!));
            },
            decoration: const InputDecoration(
              labelText: 'Select Tournament',
              border: OutlineInputBorder(),
            ),
          ),
          if (_selectedTournament != null) const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMatchupList(MatchupLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: state.matchups.length,
        itemBuilder: (context, index) {
          final MatchupEntity matchup = state.matchups[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: matchup.matchups
                  .map((pair) => ListTile(
                        title: Text(
                          '${pair.participant1} vs ${pair.participant2}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: const Icon(Icons.sports_esports),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
