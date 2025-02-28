// tournament_state.dart (Canvas 12)
import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

abstract class TournamentState extends Equatable {
  @override
  List<Object> get props => [];
}

class TournamentInitial extends TournamentState {}

class TournamentLoading extends TournamentState {}

class TournamentLoaded extends TournamentState {
  final List<TournamentEntity> tournaments;

  TournamentLoaded(this.tournaments);

  @override
  List<Object> get props => [tournaments];
}

class TournamentNamesLoaded extends TournamentState {
  final List<String> tournamentNames;

  TournamentNamesLoaded(this.tournamentNames);

  @override
  List<Object> get props => [tournamentNames];
}

class TournamentError extends TournamentState {
  final String message;

  TournamentError(this.message);

  @override
  List<Object> get props => [message];
}

class TournamentSuccess extends TournamentState {
  final String message;

  TournamentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class GameListLoaded extends TournamentState {
  final List<String> gameList;

  GameListLoaded(this.gameList);

  @override
  List<Object> get props => [gameList];
}
