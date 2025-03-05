import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';

class TournamentRemoteDataSource {
  final Dio _dio;

  TournamentRemoteDataSource(this._dio);

  Future<void> createTournament(TournamentEntity tournament) async {
    try {
      await _dio.post(ApiEndpoints.createTournament, data: tournament.toJson());
    } on DioException catch (e) {
      throw Exception("Dio error creating tournament: ${e.message}");
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
    } on DioException catch (e) {
      throw Exception("Dio error fetching tournaments: ${e.message}");
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
    } on DioException catch (e) {
      throw Exception("Dio error fetching tournament names: ${e.message}");
    } catch (e) {
      throw Exception("Failed to fetch tournament names: $e");
    }
  }

  Future<List<String>> fetchGameList() async {
    try {
      final response = await _dio.get(ApiEndpoints.getGameNamesList);

      if (response.data is List) {
        return (response.data as List).map((item) {
          if (item is Map && item.containsKey("name")) {
            return item["name"].toString(); // Extract "name" value
          } else {
            return ""; // Or handle the error differently
          }
        }).toList();
      } else {
        throw Exception("API response is not a list.");
      }
    } on DioException catch (e) {
      print("DioError: ${e.message}");
      print("DioError Response: ${e.response}");
      throw Exception("Dio error fetching games: ${e.message}");
    } catch (e) {
      throw Exception("Failed to fetch games: $e");
    }
  }
}
