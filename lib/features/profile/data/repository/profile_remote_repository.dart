import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/profile/data/data_source/remote_data_source.dart/profile_remote_data_source.dart';
import 'package:game_mgnt/features/profile/domain/entity/profile_entity.dart';
import 'package:game_mgnt/features/profile/domain/repository/profile_repository.dart';

class ProfileRemoteRepository implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final apiModel = await remoteDataSource.getProfile();
      return Right(apiModel.toEntity());
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
