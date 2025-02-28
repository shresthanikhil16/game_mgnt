import 'package:equatable/equatable.dart';

abstract class MatchupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMatchups extends MatchupEvent {
  final String tournament;

  FetchMatchups(this.tournament);

  @override
  List<Object> get props => [tournament];
}

class FetchUniqueTournaments extends MatchupEvent {}
