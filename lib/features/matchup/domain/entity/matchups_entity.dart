class MatchupEntity {
  final String tournament;
  final List<MatchupPairEntity> matchups;

  MatchupEntity({required this.tournament, required this.matchups});
}

class MatchupPairEntity {
  final String participant1;
  final String participant2;

  MatchupPairEntity({required this.participant1, required this.participant2});
}
