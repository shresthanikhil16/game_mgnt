import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryEntity>>> getWinners();
}
