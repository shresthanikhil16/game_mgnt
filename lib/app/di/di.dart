import 'package:dio/dio.dart';
import 'package:game_mgnt/app/shared_prefs/token_shared_prefs.dart';
import 'package:game_mgnt/core/network/api_service.dart';
import 'package:game_mgnt/core/network/hive_service.dart';
import 'package:game_mgnt/features/auth/data/data_source/auth_local_data_souce/auth_local_data_source.dart';
import 'package:game_mgnt/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:game_mgnt/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:game_mgnt/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:game_mgnt/features/auth/domain/use_case/login_usecase.dart';
import 'package:game_mgnt/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:game_mgnt/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:game_mgnt/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:game_mgnt/features/match_register/data/data_source/remote_data_source/tournament_reg_remote_data_source.dart';
import 'package:game_mgnt/features/match_register/data/repository/tournament_reg_remote_repository.dart';
import 'package:game_mgnt/features/match_register/domain/use_case/usecase.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_bloc.dart';
import 'package:game_mgnt/features/matchup/data/data_source/remote_data_source/matchups_remote_data_source.dart';
import 'package:game_mgnt/features/matchup/data/repository/matchups_remote_repository.dart';
import 'package:game_mgnt/features/matchup/domain/repository/matchups_repository.dart';
import 'package:game_mgnt/features/matchup/domain/use_case/matchups_usecase.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_bloc.dart';
import 'package:game_mgnt/features/tournament_creation/data/data_source/remote_data_source.dart/tournament_creation_remote_data_source.dart';
import 'package:game_mgnt/features/tournament_creation/data/repository/tournament_creation_remote_repository.dart';
import 'package:game_mgnt/features/tournament_creation/domain/use_case/get_tournament_usecase.dart';
import 'package:game_mgnt/features/tournament_creation/domain/use_case/tournament_creation_usecase.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  await _initSharedPreferences();
  _initApiService();
  _initDashboardDependencies();
  _initRegisterDependencies();
  _initLoginDependencies();
  _initTournamentDependencies();
  _initTournamentRegistrationDependencies();
  _initMatchupDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void _initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

// =========================== Dashboard ===========================
void _initDashboardDependencies() {
  getIt.registerFactory<DashboardCubit>(() => DashboardCubit());
}

// =========================== Auth/Register ===========================
void _initRegisterDependencies() {
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );
  getIt.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUseCase: getIt(),
    ),
  );
}

// =========================== Auth/Login ===========================
void _initLoginDependencies() {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      dashboardCubit: getIt<DashboardCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// =========================== Tournament Creation ===========================
void _initTournamentDependencies() {
  getIt.registerLazySingleton<TournamentRemoteDataSource>(
    () => TournamentRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<TournamentRepository>(
    () => TournamentRepository(getIt<TournamentRemoteDataSource>()),
  );

  getIt.registerLazySingleton<CreateTournamentUseCase>(
    () => CreateTournamentUseCase(getIt<TournamentRepository>()),
  );
  getIt.registerLazySingleton<GetTournamentsUseCase>(
    () => GetTournamentsUseCase(getIt<TournamentRepository>()),
  );

  getIt.registerFactory<TournamentBloc>(
    () => TournamentBloc(getIt<TournamentRepository>()),
  );
}

// =========================== Tournament Registration ===========================
void _initTournamentRegistrationDependencies() {
  getIt.registerLazySingleton<TournamentRegistrationRemoteDataSource>(
    () => TournamentRegistrationRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<TournamentRegistrationRepository>(
    () => TournamentRegistrationRepository(
        getIt<TournamentRegistrationRemoteDataSource>()),
  );

  getIt.registerLazySingleton<RegisterPlayerUseCase>(
    () => RegisterPlayerUseCase(getIt<TournamentRegistrationRepository>()),
  );
  getIt.registerLazySingleton<GetRegisteredPlayersUseCase>(
    () =>
        GetRegisteredPlayersUseCase(getIt<TournamentRegistrationRepository>()),
  );
  getIt.registerLazySingleton<GetTournamentNamesUseCase>(
    () => GetTournamentNamesUseCase(getIt<TournamentRegistrationRepository>()),
  );
  // Add the new use case registration
  getIt.registerLazySingleton<GetAllGameNamesUseCase>(
    () => GetAllGameNamesUseCase(getIt<TournamentRegistrationRepository>()),
  );

  getIt.registerFactory<TournamentRegistrationBloc>(
    () => TournamentRegistrationBloc(
      registerPlayerUseCase: getIt(),
      getRegisteredPlayersUseCase: getIt(),
      getTournamentNamesUseCase: getIt(),
      getAllGameNamesUseCase: getIt(), // Include the new use case
    ),
  );
}

// =========================== Matchup ===========================
void _initMatchupDependencies() {
  getIt.registerLazySingleton<MatchupRemoteDataSource>(
    () => MatchupRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<MatchupRepository>(
    () => MatchupRemoteRepository(getIt<MatchupRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetMatchupsUseCase>(
    () => GetMatchupsUseCase(getIt<MatchupRepository>()),
  );

  getIt.registerLazySingleton<GetUniqueTournamentsUseCase>(
    () => GetUniqueTournamentsUseCase(getIt<MatchupRepository>()),
  );

  getIt.registerFactory<MatchupBloc>(
    () => MatchupBloc(
      getMatchupsUseCase: getIt<GetMatchupsUseCase>(),
      getUniqueTournamentsUseCase: getIt<GetUniqueTournamentsUseCase>(),
    ),
  );
}
