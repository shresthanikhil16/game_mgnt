import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_bloc.dart';
import 'package:game_mgnt/features/onboarding/presentation/view/onboarding_view.dart';

import 'di/di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guide Engine',
      home: MultiBlocProvider(
        providers: [
          // Providing LoginBloc
          BlocProvider.value(
            value: getIt<LoginBloc>(),
          ),
          // Providing TournamentBloc
          BlocProvider.value(
            value: getIt<CommentsBloc>(),
          ),
        ],
        child: OnboardingView(),
      ),
    );
  }
}
