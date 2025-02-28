import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:game_mgnt/features/matchup/presentation/view/matchup_vew.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_bloc.dart';

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
            value: getIt<MatchupBloc>(),
          ),
        ],
        child: MatchupView(),
      ),
    );
  }
}
