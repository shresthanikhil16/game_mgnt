import 'package:flutter/material.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  _GamesViewState createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  // Controllers to handle form input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Selected tournament
  String? _selectedTournament;

  // List of tournaments
  final List<String> _tournaments = [
    'Tournament A',
    'Tournament B',
    'Tournament C',
    'Tournament D',
  ];

  // Global key for the form to validate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register for Tournament'),
        backgroundColor: const Color(0xFF990000), // Match the dashboard theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tournament Dropdown
              DropdownButtonFormField<String>(
                value: _selectedTournament,
                decoration: const InputDecoration(
                  labelText: 'Select Tournament',
                  border: OutlineInputBorder(),
                ),
                items: _tournaments.map((tournament) {
                  return DropdownMenuItem<String>(
                    value: tournament,
                    child: Text(tournament),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTournament = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a tournament';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF990000), // Match the dashboard theme
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, display the entered data (you can send it to a server here)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Successful'),
          content: Text(
            'Name: ${_nameController.text}\nEmail: ${_emailController.text}\nTournament: $_selectedTournament',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      // Clear the form fields after submission
      _nameController.clear();
      _emailController.clear();
      setState(() {
        _selectedTournament = null;
      });
    }
  }
}
