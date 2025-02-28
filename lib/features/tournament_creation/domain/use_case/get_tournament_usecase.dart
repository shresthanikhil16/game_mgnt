// get_usecase.dart (Canvas 8)
import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:game_mgnt/features/tournament_creation/domain/repository/tournament_creation_repository.dart';

class GetTournamentsUseCase {
  final ITournamentRepository repository;

  GetTournamentsUseCase(this.repository);

  Future<Either<Failure, List<TournamentEntity>>> call(String game) async {
    return await repository.getTournamentsByGame(game);
  }
}
