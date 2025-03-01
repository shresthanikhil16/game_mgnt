// lib/features/history/data/repository/history_repository_remote.dart
import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/history/data/data_source/remote_data_source/history_remote_data_source.dart';
import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';
import 'package:game_mgnt/features/history/domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HistoryEntity>>> getWinners() async {
    try {
      final apiModels = await remoteDataSource.getWinners();
      final entities = apiModels.map((model) => model.toEntity()).toList();
      print('HistoryRepositoryImpl: Entities: $entities'); // Log the entities
      return Right(entities);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
