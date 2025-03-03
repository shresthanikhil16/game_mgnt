// tournament_creation_state.dart
import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

abstract class TournamentState extends Equatable {
  const TournamentState();

  @override
  List<Object?> get props => [];
}

class TournamentInitial extends TournamentState {}

class TournamentLoading extends TournamentState {}

class TournamentLoaded extends TournamentState {
  final List<TournamentEntity> tournaments;

  const TournamentLoaded(this.tournaments);

  @override
  List<Object?> get props => [tournaments];
}

class TournamentNamesLoaded extends TournamentState {
  final List<String> names;

  const TournamentNamesLoaded(this.names);

  @override
  List<Object?> get props => [names];
}

class GameListLoaded extends TournamentState {
  final List<String> gameList;

  const GameListLoaded(this.gameList);

  @override
  List<Object?> get props => [gameList];
}

class TournamentSuccess extends TournamentState {
  final String message;

  const TournamentSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TournamentError extends TournamentState {
  final String message;

  const TournamentError(this.message); // Corrected constructor

  @override
  List<Object?> get props => [message];
}
