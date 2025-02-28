import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/match_register/data/data_source/remote_data_source/tournament_reg_remote_data_source.dart';
import 'package:game_mgnt/features/match_register/data/model/tournamet_reg_api_model.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';
import 'package:game_mgnt/features/match_register/domain/repository/tournament_reg_repository.dart';

class TournamentRegistrationRepository
    implements ITournamentRegistrationRepository {
  final TournamentRegistrationRemoteDataSource remoteDataSource;

  TournamentRegistrationRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> registerPlayer(
      TournamentRegistrationEntity player) async {
    try {
      final apiModel = TournamentRegistrationApiModel.fromEntity(player);
      await remoteDataSource.registerPlayer(apiModel);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TournamentRegistrationEntity>>>
      getRegisteredPlayers() async {
    try {
      final players = await remoteDataSource.getRegisteredPlayers();
      return Right(players);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getTournamentNames(String game) async {
    try {
      final tournamentNames = await remoteDataSource.getTournamentNames(game);
      return Right(tournamentNames);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllGameNames() async {
    try {
      final gameNames = await remoteDataSource.getAllGameNames();
      return Right(gameNames);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
