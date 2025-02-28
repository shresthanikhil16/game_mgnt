import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/matchup/data/data_source/remote_data_source/matchups_remote_data_source.dart';
import 'package:game_mgnt/features/matchup/domain/entity/matchups_entity.dart';
import 'package:game_mgnt/features/matchup/domain/repository/matchups_repository.dart';

class MatchupRemoteRepository implements MatchupRepository {
  final MatchupRemoteDataSource remoteDataSource;

  MatchupRemoteRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, List<MatchupEntity>>> getMatchupsByTournament(
      String tournament) async {
    try {
      final matchups =
          await remoteDataSource.getMatchupsByTournament(tournament);
      return Right(matchups.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUniqueTournaments() async {
    try {
      final tournaments = await remoteDataSource.getUniqueTournaments();
      return Right(tournaments);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
