// data_source.dart (Canvas 2)
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

abstract interface class ITournamentDataSource {
  Future<void> createTournament(TournamentEntity tournament);
  Future<List<TournamentEntity>> getTournaments(String game);
  Future<List<String>> getTournamentNames(String game);
  Future<List<String>> getGameList();
}
