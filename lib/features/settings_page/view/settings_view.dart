import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/core/theme/app_theme.dart';
import 'package:game_mgnt/core/theme/theme_cubit.dart';
import 'package:game_mgnt/features/about_us/view/about_us_view.dart'; // Import AboutUsView
import 'package:game_mgnt/features/auth/presentation/view/login_view.dart';
import 'package:game_mgnt/features/auth/presentation/view/profile_view.dart'; // Import ProfileView
import 'package:game_mgnt/features/contact_us/view/contact_us_view.dart'; // Import ContactUsView
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Remove the debug banner
          theme:
              isDarkMode ? AppTheme.getDarkTheme() : AppTheme.getLightTheme(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF990000),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: ListView(
              children: [
                ListTile(
                  leading: const Icon(CupertinoIcons.person),
                  title: const Text('Account'),
                  subtitle: const Text('Manage your account details'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Profile View
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileView()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Notifications'),
                  subtitle: const Text('Manage notification preferences'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.lock),
                  title: const Text('Privacy & Security'),
                  subtitle: const Text('Manage your privacy settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to About Us View
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.question_circle),
                  title: const Text('Help & Support'),
                  subtitle: const Text('Get support or FAQs'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Contact Us View
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactScreen()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(CupertinoIcons.moon),
                  title: const Text('Dark Mode'),
                  subtitle: Text(isDarkMode ? 'Enabled' : 'Disabled'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(value);
                    },
                    activeColor: const Color(0xFF990000),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    // Show snack bar with "Logging out" message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logging out...')),
                    );

                    // Clear shared preferences
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    // Navigate to the login page after a delay to show the snack bar
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
