import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_bloc.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_event.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_state.dart';

class TournamentRegistrationForm extends StatefulWidget {
  const TournamentRegistrationForm({super.key});

  @override
  _TournamentRegistrationFormState createState() =>
      _TournamentRegistrationFormState();
}

class _TournamentRegistrationFormState
    extends State<TournamentRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _teamNumberController = TextEditingController();
  String? _selectedGame;
  String? _selectedTournament;
  List<String> _tournamentNames = [];
  List<String> _gameNames = []; // List to store game names

  @override
  void initState() {
    super.initState();
    context
        .read<TournamentRegistrationBloc>()
        .add(FetchAllGameNames()); // Fetch all game names
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tournament Registration',
          style: TextStyle(color: Colors.white), // Title changed to white
        ),
        backgroundColor: const Color(0xFF990000),
        iconTheme:
            const IconThemeData(color: Colors.white), // Back button white
      ),
      body:
          BlocListener<TournamentRegistrationBloc, TournamentRegistrationState>(
        listener: (context, state) {
          if (state is TournamentRegistrationError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is TournamentRegistrationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Player registered successfully!')));
            _clearFields();
          } else if (state is TournamentNamesLoaded) {
            setState(() {
              _tournamentNames = state.tournamentNames;
            });
          } else if (state is AllGameNamesLoaded) {
            setState(() {
              _gameNames = state.gameNames;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Register for a Tournament',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('Full Name', _nameController),
                    _buildTextField('Email', _emailController),
                    DropdownButtonFormField<String>(
                      value: _selectedGame,
                      decoration: InputDecoration(
                        labelText: 'Select Game',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      items: _gameNames
                          .map((game) =>
                              DropdownMenuItem(value: game, child: Text(game)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGame = value;
                          _selectedTournament = null;
                        });
                        context
                            .read<TournamentRegistrationBloc>()
                            .add(FetchTournamentNames(_selectedGame!));
                      },
                      validator: (value) =>
                          value == null ? 'Please select a game' : null,
                    ),
                    const SizedBox(height: 15),
                    if (_selectedGame != null)
                      DropdownButtonFormField<String>(
                        value: _selectedTournament,
                        decoration: InputDecoration(
                          labelText: 'Select Tournament',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        items: _tournamentNames
                            .map((name) => DropdownMenuItem(
                                value: name, child: Text(name)))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedTournament = value),
                        validator: (value) =>
                            value == null ? 'Please select a tournament' : null,
                      ),
                    _buildTextField('Team Number', _teamNumberController),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF990000),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _registerPlayer,
                        child: const Text('Register',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'This field is required' : null,
      ),
    );
  }

  void _registerPlayer() {
    if (_formKey.currentState!.validate()) {
      final player = TournamentRegistrationEntity(
        name: _nameController.text,
        email: _emailController.text,
        game: _selectedGame!,
        tournament: _selectedTournament!,
        teamNumber: _teamNumberController.text,
      );
      context.read<TournamentRegistrationBloc>().add(RegisterPlayer(player));
    }
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _teamNumberController.clear();
    setState(() {
      _selectedTournament = null;
    });
  }
}
