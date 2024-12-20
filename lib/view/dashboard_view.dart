import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_mgnt/core/common/my_card_view.dart';
import 'package:game_mgnt/view/about_view.dart';
import 'package:game_mgnt/view/comments_view.dart';
import 'package:game_mgnt/view/contact_view.dart';
import 'package:game_mgnt/view/games_view.dart';
import 'package:game_mgnt/view/history_view.dart';
import 'package:game_mgnt/view/matchup_vew.dart';
import 'package:game_mgnt/view/profile_view.dart';
import 'package:game_mgnt/view/registered_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0; // Track the selected index for the bottom navigation

  // List of pages/screens for the navigation
  final List<Widget> _pages = [
    const DashboardScreen(), // Use DashboardScreen as the home screen
    const ProfileView(),
    const CommentsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex], // Display selected page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: 'Comments',
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(context),
        _buildDashboardGrid(context),
      ],
    );
  }

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

  Widget _buildDashboardGrid(BuildContext context) {
    final dashboardItems = [
      {
        'title': 'Games',
        'icon': CupertinoIcons.game_controller_solid,
        'color': Colors.deepOrange, // Ensure it's a valid Color type
        'page': const GamesView(),
      },
      {
        'title': 'History',
        'icon': CupertinoIcons.time_solid,
        'color': Colors.green, // Ensure it's a valid Color type
        'page': const HistoryView(),
      },
      {
        'title': 'Registered',
        'icon': CupertinoIcons.doc_person_fill,
        'color': Colors.redAccent, // Ensure it's a valid Color type
        'page': const RegisteredView(),
      },
      {
        'title': 'Profile',
        'icon': CupertinoIcons.person_crop_circle,
        'color': Colors.teal, // Ensure it's a valid Color type
        'page': const ProfileView(),
      },
      {
        'title': 'Comments',
        'icon': CupertinoIcons.chat_bubble_2,
        'color': Colors.brown, // Ensure it's a valid Color type
        'page': const CommentsView(),
      },
      {
        'title': 'MatchUps',
        'icon': CupertinoIcons.graph_circle,
        'color': Colors.indigo, // Ensure it's a valid Color type
        'page': MatchupView(),
      },
      {
        'title': 'About',
        'icon': CupertinoIcons.question_circle,
        'color': Colors.blue, // Ensure it's a valid Color type
        'page': const AboutView(),
      },
      {
        'title': 'Contact',
        'icon': CupertinoIcons.phone,
        'color': Colors.pinkAccent, // Ensure it's a valid Color type
        'page': const ContactView(),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: dashboardItems.length,
        itemBuilder: (context, index) {
          final item = dashboardItems[index];
          return MyCardView(
            label: item['title'] as String, // Explicitly casting to String
            icon: item['icon'] as IconData, // Explicitly casting to IconData
            color: item['color'] as Color, // Explicitly casting to Color
            page: item['page'] as Widget, // Explicitly casting to Widget
          );
        },
      ),
    );
  }
}
