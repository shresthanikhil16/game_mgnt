import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/matchup/domain/entity/matchups_entity.dart';
import 'package:game_mgnt/features/matchup/domain/repository/matchups_repository.dart';

class GetMatchupsUseCase {
  final MatchupRepository repository;

  GetMatchupsUseCase(this.repository);

  Future<Either<Failure, List<MatchupEntity>>> execute(
      String tournament) async {
    return await repository.getMatchupsByTournament(tournament);
  }
}

class GetUniqueTournamentsUseCase {
  final MatchupRepository repository;

  GetUniqueTournamentsUseCase(this.repository);

  Future<Either<Failure, List<String>>> execute() async {
    return await repository.getUniqueTournaments();
  }
}
