import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_bloc.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_event.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_state.dart';

class CreateTournamentView extends StatefulWidget {
  const CreateTournamentView({super.key});

  @override
  _CreateTournamentViewState createState() => _CreateTournamentViewState();
}

class _CreateTournamentViewState extends State<CreateTournamentView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _prizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _games = [];
  String? _selectedGame;

  @override
  void initState() {
    super.initState();
    context.read<TournamentBloc>().add(FetchGameList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create a Tournament',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF990000),
      ),
      body: BlocListener<TournamentBloc, TournamentState>(
        listener: (context, state) {
          if (state is TournamentError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is TournamentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Tournament Created Successfully!")));
            _clearFields();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TournamentBloc, TournamentState>(
            builder: (context, state) {
              if (state is TournamentLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextFormField(
                        controller: _nameController,
                        label: 'Tournament Name',
                        validator: (value) => value!.isEmpty
                            ? 'Please enter tournament name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdownField(),
                      const SizedBox(height: 16),
                      _buildDateField(
                        controller: _startDateController,
                        label: 'Start Date',
                      ),
                      const SizedBox(height: 16),
                      _buildDateField(
                        controller: _endDateController,
                        label: 'End Date',
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: _prizeController,
                        label: 'Prize',
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter prize amount' : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: _descriptionController,
                        label: 'Description',
                        maxLines: 3,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a description'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _createTournament,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF990000),
                        ),
                        child: const Text(
                          'Create a Tournament',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black), // Set text color to black
    );
  }

  Widget _buildDropdownField() {
    return BlocBuilder<TournamentBloc, TournamentState>(
      builder: (context, state) {
        if (state is GameListLoaded) {
          _games = state.gameList;
        }
        return DropdownButtonFormField<String>(
          value: _selectedGame,
          decoration: const InputDecoration(
            labelText: 'Select Game',
            border: OutlineInputBorder(),
          ),
          items: _games
              .map((game) => DropdownMenuItem(value: game, child: Text(game)))
              .toList(),
          onChanged: (value) => setState(() => _selectedGame = value),
          validator: (value) => value == null ? 'Please select a game' : null,
        );
      },
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? pickedDate = await _selectDate();
        if (pickedDate != null) {
          controller.text = pickedDate.toIso8601String().split("T")[0];
        }
      },
      readOnly: true,
      style: const TextStyle(color: Colors.black), // Set text color to black
    );
  }

  void _createTournament() {
    if (_formKey.currentState!.validate()) {
      final tournament = TournamentEntity(
        name: _nameController.text,
        game: _selectedGame!,
        startDate: DateTime.parse(_startDateController.text),
        endDate: DateTime.parse(_endDateController.text),
        prize: _prizeController.text,
        description: _descriptionController.text,
      );
      context.read<TournamentBloc>().add(CreateTournament(tournament));
    }
  }

  void _clearFields() {
    _nameController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _prizeController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedGame = null;
    });
  }

  Future<DateTime?> _selectDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }
}
