import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';

abstract class TournamentRegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterPlayer extends TournamentRegistrationEvent {
  final TournamentRegistrationEntity player;

  RegisterPlayer(this.player);

  @override
  List<Object> get props => [player];
}

class FetchRegisteredPlayers extends TournamentRegistrationEvent {}

class FetchTournamentNames extends TournamentRegistrationEvent {
  final String game;

  FetchTournamentNames(this.game);

  @override
  List<Object> get props => [game];
}

class FetchAllGameNames extends TournamentRegistrationEvent {} // New event
