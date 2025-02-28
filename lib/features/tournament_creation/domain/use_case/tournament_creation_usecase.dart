import 'package:dartz/dartz.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:game_mgnt/features/tournament_creation/domain/repository/tournament_creation_repository.dart';

import '../../../../core/error/failure.dart';

class CreateTournamentUseCase {
  final ITournamentRepository tournamentRepository;

  CreateTournamentUseCase(this.tournamentRepository);

  Future<Either<Failure, void>> execute(TournamentEntity tournament) async {
    return await tournamentRepository.createTournament(tournament);
  }
}

class GetTournamentsByGameUseCase {
  final ITournamentRepository tournamentRepository;

  GetTournamentsByGameUseCase(this.tournamentRepository);

  Future<Either<Failure, List<TournamentEntity>>> execute(String game) async {
    return await tournamentRepository.getTournamentsByGame(game);
  }
}

class GetTournamentNamesByGameUseCase {
  final ITournamentRepository tournamentRepository;

  GetTournamentNamesByGameUseCase(this.tournamentRepository);

  Future<Either<Failure, List<String>>> execute(String game) async {
    return await tournamentRepository.getTournamentNamesByGame(game);
  }
}
