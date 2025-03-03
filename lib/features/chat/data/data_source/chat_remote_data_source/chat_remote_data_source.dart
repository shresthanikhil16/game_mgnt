import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart'; // Make sure this is imported
import 'package:game_mgnt/features/chat/data/model/chat_api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteMessageDataSource {
  final Dio _dio;

  RemoteMessageDataSource(this._dio);

  Future<ApiMessageModel> sendMessage(String receiver, String text) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found. Please log in.');
      }

      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}messages/', // Use ApiEndpoints.baseUrl and append 'messages/'
        data: {
          'receiver': receiver,
          'text': text,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
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
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found. Please log in.');
      }

      final response = await _dio.get(
        '${ApiEndpoints.baseUrl}messages/$userId', // Use ApiEndpoints.baseUrl and append 'messages/$userId'
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

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

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
