import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // Default theme mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white), // White text color
        ),
        backgroundColor: const Color(0xFF990000),
        iconTheme:
            const IconThemeData(color: Colors.white), // White back button
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(CupertinoIcons.person),
            title: Text('Account'),
            subtitle: Text('Manage your account details'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            leading: Icon(CupertinoIcons.bell),
            title: Text('Notifications'),
            subtitle: Text('Manage notification preferences'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            leading: Icon(CupertinoIcons.lock),
            title: Text('Privacy & Security'),
            subtitle: Text('Manage your privacy settings'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            leading: Icon(CupertinoIcons.question_circle),
            title: Text('Help & Support'),
            subtitle: Text('Get support or FAQs'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(), // Separator
          ListTile(
            leading: const Icon(CupertinoIcons.moon),
            title: const Text('Dark Mode'),
            subtitle: Text(_isDarkMode ? 'Enabled' : 'Disabled'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
                // You can implement ThemeMode switching logic here
              },
              activeColor:
                  const Color(0xFF990000), // Custom color for active state
            ),
          ),
        ],
      ),
    );
  }
}
