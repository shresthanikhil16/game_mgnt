import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart';
import 'package:game_mgnt/features/matchup/data/model/matchups_api_model.dart';

class MatchupRemoteDataSource {
  final Dio _dio;

  MatchupRemoteDataSource(this._dio);

  Future<List<MatchupApiModel>> getMatchupsByTournament(
      String tournament) async {
    try {
      final response =
          await _dio.get('${ApiEndpoints.getMatchups}/$tournament');
      return (response.data as List)
          .map((json) => MatchupApiModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get matchups: $e');
    }
  }

  Future<List<String>> getUniqueTournaments() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUniqueTournaments);
      return (response.data as List)
          .map((tournament) => tournament.toString())
          .toList();
    } catch (e) {
      throw Exception('Failed to get unique tournaments: $e');
    }
  }
}
