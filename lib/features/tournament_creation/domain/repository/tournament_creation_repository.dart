// tournament_creation_repository.dart (Canvas 6)
import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

abstract class ITournamentRepository {
  Future<Either<Failure, void>> createTournament(TournamentEntity tournament);
  Future<Either<Failure, List<TournamentEntity>>> getTournamentsByGame(
      String game);
  Future<Either<Failure, List<String>>> getTournamentNamesByGame(String game);
  Future<Either<Failure, List<String>>> getGameList();
}
