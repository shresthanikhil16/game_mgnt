import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/core/common/card_view/my_card_view.dart';
import 'package:game_mgnt/core/theme/app_theme.dart';
import 'package:game_mgnt/core/theme/theme_cubit.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: const DashboardViewBody(),
    );
  }
}

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
              isDarkMode ? AppTheme.getDarkTheme() : AppTheme.getLightTheme(),
          home: const SafeArea(
            child: Scaffold(
              body: DashboardScreen(),
            ),
          ),
        );
      },
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount =
        screenWidth > 600 ? 3 : 2; // Adjust grid for tablets

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: dashboardItems.length,
                  itemBuilder: (context, index) {
                    final item = dashboardItems[index];
                    return MyCardView(
                      label: item['title'] as String,
                      icon: item['icon'] as IconData,
                      color: item['color'] as Color,
                      page: item['page'] as Widget,
                    );
                  },
                );
              },
            ),
          ),
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
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Hello Pratham!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Good Morning',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
            ),
            trailing: const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/images/logo2.png'),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> dashboardItems = [
  {
    'title': 'Games',
    'icon': CupertinoIcons.game_controller_solid,
    'color': Colors.deepOrange,
    'page': const Placeholder(),
  },
  {
    'title': 'History',
    'icon': CupertinoIcons.time_solid,
    'color': Colors.green,
    'page': const Placeholder(),
  },
  {
    'title': 'Registered',
    'icon': CupertinoIcons.doc_person_fill,
    'color': Colors.redAccent,
    'page': const Placeholder(),
  },
  {
    'title': 'MatchUps',
    'icon': CupertinoIcons.graph_circle,
    'color': Colors.indigo,
    'page': const Placeholder(),
  },
  {
    'title': 'About',
    'icon': CupertinoIcons.question_circle,
    'color': Colors.blue,
    'page': const Placeholder(),
  },
  {
    'title': 'Contact',
    'icon': CupertinoIcons.phone,
    'color': Colors.pinkAccent,
    'page': const Placeholder(),
  },
];
