// tournament_remote_data_source.dart (Corrected)
import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

class TournamentRemoteDataSource {
  final Dio _dio;

  TournamentRemoteDataSource(this._dio);

  Future<void> createTournament(TournamentEntity tournament) async {
    try {
      await _dio.post(ApiEndpoints.createTournament, data: tournament.toJson());
    } catch (e) {
      throw Exception("Failed to create tournament: $e");
    }
  }

  Future<List<TournamentEntity>> fetchTournaments(String game) async {
    try {
      final response =
          await _dio.get("${ApiEndpoints.getTournamentsByGame}$game");
      return (response.data as List)
          .map((json) => TournamentEntity.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch tournaments: $e");
    }
  }

  Future<List<String>> fetchTournamentNames(String game) async {
    try {
      final response =
          await _dio.get("${ApiEndpoints.getTournamentNamesByGame}$game");
      return (response.data as List)
          .map((json) => json["name"].toString())
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch tournament names: $e");
    }
  }

  Future<List<String>> fetchGameList() async {
    try {
      final response = await _dio.get(ApiEndpoints.getGameNamesList);
      return (response.data as List).map((game) => game.toString()).toList();
    } catch (e) {
      if (e is DioException) {
        print("DioError: ${e.message}");
        print("DioError Response: ${e.response}");
      }
      throw Exception("Failed to fetch games: $e");
    }
  }
}
