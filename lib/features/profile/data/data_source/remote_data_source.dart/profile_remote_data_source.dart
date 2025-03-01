import 'package:dio/dio.dart';
import 'package:game_mgnt/app/constants/api_endpoint.dart';
import 'package:game_mgnt/features/profile/data/model/profile_api_model.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource({required this.dio});

  Future<ProfileApiModel> getProfile() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getMe}',
        options: Options(headers: {
          'Authorization':
              'Bearer YOUR_AUTH_TOKEN', // Replace with your actual token
        }),
      );

      if (response.statusCode == 200) {
        return ProfileApiModel.fromJson(response.data);
      } else {
        // Handle non-200 status codes
        print('API Error: Status Code ${response.statusCode}');
        return ProfileApiModel(
          username: 'Error',
          email: 'Error',
          profilePicture: '',
        ); // Return a default ProfileApiModel
      }
    } on DioException catch (e) {
      return ProfileApiModel(
        username: 'Error',
        email: 'Error',
        profilePicture: '',
      ); // Return a default ProfileApiModel
    } catch (e) {
      return ProfileApiModel(
        username: 'Error',
        email: 'Error',
        profilePicture: '',
      ); // Return a default ProfileApiModel
    }
  }
}
