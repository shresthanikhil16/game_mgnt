import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/core/network/connectivity_service.dart';
import 'package:game_mgnt/features/history/data/data_source/history_local_data_source/history_local_data_source.dart';
import 'package:game_mgnt/features/history/data/data_source/remote_data_source/history_remote_data_source.dart';
import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';
import 'package:game_mgnt/features/history/domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;
  final HistoryLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  HistoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivityService,
  });

  @override
  Future<Either<Failure, List<HistoryEntity>>> getWinners() async {
    final isConnected = await connectivityService.isConnected();
    if (isConnected) {
      try {
        final apiModels = await remoteDataSource.getWinners();
        final entities = apiModels.map((model) => model.toEntity()).toList();
        await localDataSource.cacheWinners(apiModels); // Cache for offline use
        print('HistoryRepositoryImpl: Fetched and cached entities: $entities');
        return Right(entities);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      try {
        final cachedModels = await localDataSource.getWinners();
        if (cachedModels.isNotEmpty) {
          final entities =
              cachedModels.map((model) => model.toEntity()).toList();
          print('HistoryRepositoryImpl: Loaded cached entities: $entities');
          return Right(entities);
        } else {
          return Left(ApiFailure(
              message: 'No internet connection and no cached data available'));
        }
      } catch (e) {
        return Left(ApiFailure(message: 'Failed to load cached data: $e'));
      }
    }
  }
}
