// create_usecase.dart (Canvas 7 continued)
import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/tournament_creation/data/repository/tournament_creation_remote_repository.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

class CreateTournamentUseCase {
  final TournamentRepository repository;

  CreateTournamentUseCase(this.repository);

  Future<Either<Failure, void>> execute(TournamentEntity tournament) async {
    return await repository.createTournament(tournament);
  }
}
