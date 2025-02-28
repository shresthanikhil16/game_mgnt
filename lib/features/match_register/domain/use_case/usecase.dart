import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';
import 'package:game_mgnt/features/match_register/domain/repository/tournament_reg_repository.dart';

class RegisterPlayerUseCase {
  final ITournamentRegistrationRepository repository;

  RegisterPlayerUseCase(this.repository);

  Future<Either<Failure, void>> execute(
      TournamentRegistrationEntity player) async {
    return await repository.registerPlayer(player);
  }
}

class GetRegisteredPlayersUseCase {
  final ITournamentRegistrationRepository repository;

  GetRegisteredPlayersUseCase(this.repository);

  Future<Either<Failure, List<TournamentRegistrationEntity>>> execute() async {
    return await repository.getRegisteredPlayers();
  }
}

class GetTournamentNamesUseCase {
  final ITournamentRegistrationRepository repository;

  GetTournamentNamesUseCase(this.repository);

  Future<Either<Failure, List<String>>> execute(String game) async {
    return await repository.getTournamentNames(game);
  }
}

class GetAllGameNamesUseCase {
  final ITournamentRegistrationRepository repository;

  GetAllGameNamesUseCase(this.repository);

  Future<Either<Failure, List<String>>> execute() async {
    return await repository.getAllGameNames();
  }
}
