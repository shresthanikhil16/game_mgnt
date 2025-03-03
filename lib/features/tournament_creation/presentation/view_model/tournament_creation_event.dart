//tournament_creation_event.dart
import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

abstract class TournamentEvent extends Equatable {
  const TournamentEvent();

  @override
  List<Object?> get props => [];
}

class CreateTournament extends TournamentEvent {
  final TournamentEntity tournament;

  const CreateTournament(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class FetchTournaments extends TournamentEvent {
  final String game;

  const FetchTournaments(this.game);

  @override
  List<Object?> get props => [game];
}

class FetchTournamentNames extends TournamentEvent {
  final String game;

  const FetchTournamentNames(this.game);

  @override
  List<Object?> get props => [game];
}

class FetchGameList extends TournamentEvent {
  const FetchGameList();
}
