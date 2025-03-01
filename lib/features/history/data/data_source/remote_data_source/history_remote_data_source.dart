import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart';
import 'package:game_mgnt/features/history/data/model/history_api_model.dart';

class HistoryRemoteDataSource {
  final Dio dio;

  HistoryRemoteDataSource({required this.dio});

  Future<List<HistoryApiModel>> getWinners() async {
    try {
      final response =
          await dio.get('${ApiEndpoints.baseUrl}${ApiEndpoints.getWinners}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        return jsonResponse
            .map((json) => HistoryApiModel.fromJson(json))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}'); // Log the error
      return []; // Return an empty list on error
    } catch (e) {
      print('General Error: $e'); // Log the error
      return []; // Return an empty list on error
    }
  }
}
