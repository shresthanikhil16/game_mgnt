import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart';
import 'package:game_mgnt/features/match_register/data/model/tournamet_reg_api_model.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';

class TournamentRegistrationRemoteDataSource {
  final Dio _dio;

  TournamentRegistrationRemoteDataSource(this._dio);

  Future<void> registerPlayer(TournamentRegistrationApiModel player) async {
    try {
      await _dio.post(ApiEndpoints.registerPlayer, data: player.toJson());
    } catch (e) {
      throw Exception("Failed to register player: $e");
    }
  }

  Future<List<TournamentRegistrationEntity>> getRegisteredPlayers() async {
    try {
      final response = await _dio.get(ApiEndpoints.getRegisteredPlayers);
      return (response.data as List)
          .map((json) =>
              TournamentRegistrationApiModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception("Failed to get registered players: $e");
    }
  }

  Future<List<String>> getTournamentNames(String game) async {
    try {
      final response =
          await _dio.get('${ApiEndpoints.getTournamentNamesByGame}$game');
      return (response.data as List)
          .map((json) => json['name'].toString())
          .toList();
    } catch (e) {
      throw Exception('Failed to get tournament names: $e');
    }
  }

  Future<List<String>> getAllGameNames() async {
    try {
      final response = await _dio.get(ApiEndpoints.getAllGameNames);
      return (response.data as List).map((game) => game.toString()).toList();
    } catch (e) {
      throw Exception("Failed to get all game names: $e");
    }
  }
}
