import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/core/theme/app_theme.dart';
import 'package:game_mgnt/core/theme/theme_cubit.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_bloc.dart';
import 'package:game_mgnt/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:game_mgnt/features/settings_page/view/settings_view.dart';

import 'di/di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner:
                false, // This line removes the debug banner
            title: 'Guide Engine',
            theme:
                isDarkMode ? AppTheme.getDarkTheme() : AppTheme.getLightTheme(),
            home: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: getIt<LoginBloc>(),
                ),
                BlocProvider.value(
                  value: getIt<CommentsBloc>(),
                ),
                BlocProvider(
                  create: (context) => getIt<ProfileBloc>(),
                ),
              ],
              child: const OnboardingView(),
            ),
            routes: {
              '/settings': (context) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
