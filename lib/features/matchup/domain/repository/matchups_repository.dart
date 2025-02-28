import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/matchup/domain/entity/matchups_entity.dart';

abstract class MatchupRepository {
  Future<Either<Failure, List<MatchupEntity>>> getMatchupsByTournament(
      String tournament);
  Future<Either<Failure, List<String>>> getUniqueTournaments();
}
