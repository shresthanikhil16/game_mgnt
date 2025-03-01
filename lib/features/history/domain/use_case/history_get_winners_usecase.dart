// lib/features/history/domain/use_case/history_get_winners_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';
import 'package:game_mgnt/features/history/domain/repository/history_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class GetWinnersUseCase implements UseCase<List<HistoryEntity>, NoParams> {
  final HistoryRepository repository;

  GetWinnersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<HistoryEntity>>> call(NoParams params) async {
    return await repository.getWinners();
  }
}

class NoParams {} // Define NoParams here
