import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Profile options: Only "Edit Profile" and "Logout"
    final profileOptions = [
      {'title': 'Edit Profile', 'icon': Icons.edit, 'color': Colors.deepOrange},
      {'title': 'Logout', 'icon': Icons.logout, 'color': Colors.redAccent},
    ];

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header Section
            _buildHeader(context),
            // Profile Options
            _buildProfileOptionsGrid(context, profileOptions),
          ],
        ),
      ),
    );
  }

  /// Builds the header with profile details
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF990000), Color(0xFF4B0000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          // Profile Picture
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'assets/images/logo2.png'), // Replace with user's image
          ),
          const SizedBox(height: 10),
          // User Name
          Text(
            'Pratham Shrestha',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          // User Email
          Text(
            'pratham.shrestha@example.com',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  /// Builds the profile options grid
  Widget _buildProfileOptionsGrid(
      BuildContext context, List<Map<String, dynamic>> options) {
    return Container(
      color: const Color(0xFF990000),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(200),
          ),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 40,
            mainAxisSpacing: 30,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return _buildProfileOptionItem(
              context,
              title: option['title'],
              icon: option['icon'],
              color: option['color'],
            );
          },
        ),
      ),
    );
  }

  /// Reusable profile option item widget
  Widget _buildProfileOptionItem(BuildContext context,
      {required String title, required IconData icon, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
