import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart';
import 'package:game_mgnt/features/chat/data/model/chat_api_model.dart';

class RemoteMessageDataSource {
  final Dio _dio;

  RemoteMessageDataSource(this._dio);

  Future<ApiMessageModel> sendMessage(String receiver, String text) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}messages', // Use ApiEndpoints.baseUrl
        data: {
          'receiver': receiver,
          'text': text,
        },
      );

      if (response.statusCode == 201) {
        return ApiMessageModel.fromJson(response.data['message']);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to send message: ${e.message}');
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<List<ApiMessageModel>> getMessages(String userId) async {
    try {
      final response = await _dio.get(
          '${ApiEndpoints.baseUrl}messages/$userId'); // Use ApiEndpoints.baseUrl

      if (response.statusCode == 200) {
        final List<dynamic> messagesJson = response.data['messages'];
        return messagesJson
            .map((json) => ApiMessageModel.fromJson(json))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to get messages: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }
}
