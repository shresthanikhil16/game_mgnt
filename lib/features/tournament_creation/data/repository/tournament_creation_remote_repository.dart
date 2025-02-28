// tournament_creation_remote_repository.dart (Canvas 4)
import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/tournament_creation/data/data_source/remote_data_source.dart/tournament_creation_remote_data_source.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:game_mgnt/features/tournament_creation/domain/repository/tournament_creation_repository.dart';

class TournamentRepository implements ITournamentRepository {
  final TournamentRemoteDataSource remoteDataSource;

  TournamentRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> createTournament(
      TournamentEntity tournament) async {
    try {
      await remoteDataSource.createTournament(tournament);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TournamentEntity>>> getTournamentsByGame(
      String game) async {
    try {
      final tournaments = await remoteDataSource.fetchTournaments(game);
      return Right(tournaments);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getTournamentNamesByGame(
      String game) async {
    try {
      final names = await remoteDataSource.fetchTournamentNames(game);
      return Right(names);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getGameList() async {
    try {
      final games = await remoteDataSource.fetchGameList();
      return Right(games);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
