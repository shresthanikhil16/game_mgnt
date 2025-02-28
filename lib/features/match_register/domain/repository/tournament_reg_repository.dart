import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';

abstract class ITournamentRegistrationRepository {
  Future<Either<Failure, void>> registerPlayer(
      TournamentRegistrationEntity player);
  Future<Either<Failure, List<TournamentRegistrationEntity>>>
      getRegisteredPlayers();
  Future<Either<Failure, List<String>>> getTournamentNames(String game);
  Future<Either<Failure, List<String>>> getAllGameNames(); // New method
}
