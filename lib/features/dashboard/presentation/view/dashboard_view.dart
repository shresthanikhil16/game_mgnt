import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/app/di/di.dart';
import 'package:game_mgnt/core/common/card_view/my_card_view.dart';
import 'package:game_mgnt/core/theme/app_theme.dart';
import 'package:game_mgnt/core/theme/theme_cubit.dart';
import 'package:game_mgnt/features/about_us/view/about_us_view.dart';
import 'package:game_mgnt/features/auth/domain/use_case/get_profile_usecase.dart';
import 'package:game_mgnt/features/auth/presentation/view/profile_view.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:game_mgnt/features/chat/domain/usecase/get_message_usecase.dart';
import 'package:game_mgnt/features/chat/domain/usecase/sned_message_usecase.dart';
import 'package:game_mgnt/features/chat/presentation/view/chat_view.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_bloc.dart';
import 'package:game_mgnt/features/contact_us/view/contact_us_view.dart';
import 'package:game_mgnt/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:game_mgnt/features/dashboard/presentation/view_model/dashboard_state.dart';
import 'package:game_mgnt/features/history/domain/use_case/history_get_winners_usecase.dart';
import 'package:game_mgnt/features/history/presentation/view/history_view.dart';
import 'package:game_mgnt/features/history/presentation/view_model/history_bloc.dart';
import 'package:game_mgnt/features/match_register/domain/use_case/usecase.dart';
import 'package:game_mgnt/features/match_register/presentation/view/game_registration_view.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_bloc.dart';
import 'package:game_mgnt/features/matchup/domain/use_case/matchups_usecase.dart';
import 'package:game_mgnt/features/matchup/presentation/view/matchup_vew.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_bloc.dart';
import 'package:game_mgnt/features/settings_page/view/settings_view.dart';
import 'package:game_mgnt/features/settings_page/view_model/settings_cubit.dart';
import 'package:game_mgnt/features/tournament_creation/data/repository/tournament_creation_remote_repository.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view/tournament_creation_view.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: DashboardViewBody(),
    );
  }
}

class DashboardViewBody extends StatelessWidget {
  DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
              isDarkMode ? AppTheme.getDarkTheme() : AppTheme.getLightTheme(),
          home: SafeArea(
            child: Scaffold(
              body: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  return _screens[state.selectedIndex];
                },
              ),
              bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  return BottomNavigationBar(
                    currentIndex: state.selectedIndex,
                    onTap: (index) =>
                        context.read<DashboardCubit>().onTabTapped(index),
                    selectedItemColor: const Color(0xFF990000),
                    unselectedItemColor: Colors.grey,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home),
                        label: 'Dashboard',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.settings),
                        label: 'Settings',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chat_bubble_2),
                        label: 'Chat',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person),
                        label: 'Profile',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    BlocProvider(create: (_) => SettingsCubit(), child: const SettingsScreen()),
    BlocProvider(
      create: (context) => CommentsBloc(
        sendMessageUseCase: getIt<SendMessageUseCase>(),
        getMessagesUseCase: getIt<GetMessagesUseCase>(),
      ),
      child: const CommentsView(),
    ),
    FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final token = snapshot.data;
          if (token != null) {
            return BlocProvider(
              create: (context) => ProfileBloc(getIt<GetProfileUseCase>())
                ..add(FetchProfileEvent(token)),
              child: const ProfileView(),
            );
          } else {
            return const Center(child: Text('Token not found'));
          }
        }
      },
    ),
  ];

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
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
        'page': BlocProvider(
          create: (context) => TournamentBloc(getIt<TournamentRepository>()),
          child: const CreateTournamentView(),
        ),
      },
      {
        'title': 'History',
        'icon': CupertinoIcons.time_solid,
        'color': Colors.green,
        'page': BlocProvider(
          create: (context) =>
              HistoryBloc(getWinnersUseCase: getIt<GetWinnersUseCase>()),
          child: const HistoryView(),
        ),
      },
      {
        'title': 'Registered',
        'icon': CupertinoIcons.doc_person_fill,
        'color': Colors.redAccent,
        'page': BlocProvider(
          create: (context) => TournamentRegistrationBloc(
            registerPlayerUseCase: getIt<RegisterPlayerUseCase>(),
            getRegisteredPlayersUseCase: getIt<GetRegisteredPlayersUseCase>(),
            getTournamentNamesUseCase: getIt<GetTournamentNamesUseCase>(),
            getAllGameNamesUseCase: getIt<GetAllGameNamesUseCase>(),
          ),
          child: const TournamentRegistrationForm(),
        ),
      },
      {
        'title': 'MatchUps',
        'icon': CupertinoIcons.graph_circle,
        'color': Colors.indigo,
        'page': BlocProvider(
          create: (context) => MatchupBloc(
            getMatchupsUseCase: getIt<GetMatchupsUseCase>(),
            getUniqueTournamentsUseCase: getIt<GetUniqueTournamentsUseCase>(),
          ),
          child: const MatchupView(),
        ),
      },
      {
        'title': 'About',
        'icon': CupertinoIcons.question_circle,
        'color': Colors.blue,
        'page': const AboutUsScreen(),
      },
      {
        'title': 'Contact',
        'icon': CupertinoIcons.phone,
        'color': Colors.pinkAccent,
        'page': const ContactScreen(),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.only(top: 30), // Adjust padding here
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
              page: item['page'] as Widget,
            );
          },
        ),
      ),
    );
  }
}
