import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_mgnt/core/common/card_view/my_card_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const DashboardScreen(),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap entire content in SingleChildScrollView
      child: Column(
        children: [
          _buildHeader(context),
          _buildDashboardGrid(context),
        ],
      ),
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
        'color': Colors.deepOrange,
        'page': const Placeholder(), // Replace with actual page
      },
      {
        'title': 'History',
        'icon': CupertinoIcons.time_solid,
        'color': Colors.green,
        'page': const Placeholder(), // Replace with actual page
      },
      {
        'title': 'Registered',
        'icon': CupertinoIcons.doc_person_fill,
        'color': Colors.redAccent,
        'page': const Placeholder(), // Replace with actual page
      },
      {
        'title': 'Profile',
        'icon': CupertinoIcons.person_crop_circle,
        'color': Colors.teal,
        'page': const Placeholder(), // Replace with actual page
      },
      {
        'title': 'Comments',
        'icon': CupertinoIcons.chat_bubble_2,
        'color': Colors.brown,
        'page': const Placeholder(), // Replace with actual page
      },
      {
        'title': 'MatchUps',
        'icon': CupertinoIcons.graph_circle,
        'color': Colors.indigo,
        'page': const Placeholder(), // Replace with actual page
      },
      {
        'title': 'About',
        'icon': CupertinoIcons.question_circle,
        'color': Colors.blue,
        'page': Container(), // Avoid passing `null`
      },
      {
        'title': 'Contact',
        'icon': CupertinoIcons.phone,
        'color': Colors.pinkAccent,
        'page': Container(), // Avoid passing `null`
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
            label: item['title'] as String,
            icon: item['icon'] as IconData,
            color: item['color'] as Color,
            page: item['page'] as Widget?, // Safe cast with nullable type
          );
        },
      ),
    );
  }
}
