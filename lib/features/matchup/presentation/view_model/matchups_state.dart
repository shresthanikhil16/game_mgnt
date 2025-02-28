import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/matchup/domain/entity/matchups_entity.dart';

abstract class MatchupState extends Equatable {
  @override
  List<Object> get props => [];
}

class MatchupInitial extends MatchupState {}

class MatchupLoading extends MatchupState {}

class MatchupLoaded extends MatchupState {
  final List<MatchupEntity> matchups;

  MatchupLoaded(this.matchups);

  @override
  List<Object> get props => [matchups];
}

class UniqueTournamentsLoaded extends MatchupState {
  final List<String> tournaments;

  UniqueTournamentsLoaded(this.tournaments);

  @override
  List<Object> get props => [tournaments];
}

class MatchupError extends MatchupState {
  final String message;

  MatchupError(this.message);

  @override
  List<Object> get props => [message];
}
