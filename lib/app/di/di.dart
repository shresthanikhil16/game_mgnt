import 'package:dio/dio.dart';
import 'package:game_mgnt/app/shared_prefs/token_shared_prefs.dart';
import 'package:game_mgnt/core/network/api_service.dart';
import 'package:game_mgnt/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:game_mgnt/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:game_mgnt/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:game_mgnt/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/auth_local_data_souce/auth_local_data_source.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_user_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/signup/register_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initDashboardDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initApiService();
  await _initSharedPreferences();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  //Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
// =========================== Data Source ===========================

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUseCase: getIt(),
    ),
  );
}

_initDashboardDependencies() async {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}

// =========================== Login ===========================

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
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
