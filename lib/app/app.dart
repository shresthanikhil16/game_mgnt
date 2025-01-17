import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:game_mgnt/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:game_mgnt/features/onboarding/presentation/view_model/onboarding_cubit.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/view_model/login/login_bloc.dart';
import 'di/di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingCubit>(
          create: (context) => getIt<OnboardingCubit>(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => getIt<DashboardCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Management',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: const GetStartedView(),
      ),
    );
  }
}
