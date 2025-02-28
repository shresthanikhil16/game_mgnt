import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';

abstract class TournamentRegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class TournamentRegistrationInitial extends TournamentRegistrationState {}

class TournamentRegistrationLoading extends TournamentRegistrationState {}

class TournamentRegistrationSuccess extends TournamentRegistrationState {}

class TournamentRegistrationError extends TournamentRegistrationState {
  final String message;

  TournamentRegistrationError(this.message);

  @override
  List<Object> get props => [message];
}

class RegisteredPlayersLoaded extends TournamentRegistrationState {
  final List<TournamentRegistrationEntity> players;

  RegisteredPlayersLoaded(this.players);

  @override
  List<Object> get props => [players];
}

class TournamentNamesLoaded extends TournamentRegistrationState {
  final List<String> tournamentNames;

  TournamentNamesLoaded(this.tournamentNames);

  @override
  List<Object> get props => [tournamentNames];
}

class AllGameNamesLoaded extends TournamentRegistrationState {
  final List<String> gameNames;

  AllGameNamesLoaded(this.gameNames);

  @override
  List<Object> get props => [gameNames];
}
