import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_mgnt/view/about_view.dart';
import 'package:game_mgnt/view/comments_view.dart';
import 'package:game_mgnt/view/contact_view.dart';
import 'package:game_mgnt/view/history_view.dart';
import 'package:game_mgnt/view/matchup_vew.dart';
import 'package:game_mgnt/view/profile_view.dart';
import 'package:game_mgnt/view/registered_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // List of dashboard items
    final dashboardItems = [
      {
        'title': 'Games',
        'icon': CupertinoIcons.game_controller_solid,
        'color': Colors.deepOrange,
        'page': MatchupView(), // Example navigation to MatchupView
      },
      {
        'title': 'History',
        'icon': CupertinoIcons.time_solid,
        'color': Colors.green,
        'page': const HistoryView(), // Example navigation to HistoryView
      },
      {
        'title': 'Registered',
        'icon': CupertinoIcons.doc_person_fill,
        'color': Colors.redAccent,
        'isGradient': true,
        'page': const RegisteredView(), // Example navigation to RegisteredView
      },
      {
        'title': 'Profile',
        'icon': CupertinoIcons.person_crop_circle,
        'color': Colors.teal,
        'page': const ProfileView(), // Navigation to ProfileView
      },
      {
        'title': 'Comments',
        'icon': CupertinoIcons.chat_bubble_2,
        'color': Colors.brown,
        'page': const CommentsView(), // Navigation to CommentsView
      },
      {
        'title': 'MatchUps',
        'icon': CupertinoIcons.graph_circle,
        'color': Colors.indigo,
        'page': MatchupView(), // Navigation to MatchupView
      },
      {
        'title': 'About',
        'icon': CupertinoIcons.question_circle,
        'color': Colors.blue,
        'page': const AboutView(), // Navigation to AboutView
      },
      {
        'title': 'Contact',
        'icon': CupertinoIcons.phone,
        'color': Colors.pinkAccent,
        'page': const ContactView(), // Navigation to ContactView
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header Section
            _buildHeader(context),
            // Dashboard Grid
            _buildDashboardGrid(context, dashboardItems),
          ],
        ),
      ),
    );
  }

  /// Builds the header with a gradient background
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
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            title: Text(
              'Hello Pratham!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            subtitle: Text(
              'Good Morning',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white54),
            ),
            trailing: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/logo2.png'),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  /// Builds the dashboard grid
  Widget _buildDashboardGrid(
      BuildContext context, List<Map<String, dynamic>> items) {
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
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildDashboardItem(
              context,
              title: item['title'],
              icon: item['icon'],
              color: item['color'],
              isGradient: item['isGradient'] ?? false,
              page: item['page'],
            );
          },
        ),
      ),
    );
  }

  /// Reusable dashboard item widget with navigation
  Widget _buildDashboardItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    bool isGradient = false,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to the respective page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
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
                shape: BoxShape.circle,
                gradient: isGradient
                    ? const LinearGradient(
                        colors: [Colors.redAccent, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isGradient ? null : color,
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
      ),
    );
  }
}
