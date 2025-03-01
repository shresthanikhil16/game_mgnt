import 'package:dartz/dartz.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/history/domain/use_case/history_get_winners_usecase.dart';
import 'package:game_mgnt/features/profile/domain/entity/profile_entity.dart';
import 'package:game_mgnt/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase implements UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    return await repository.getProfile();
  }
}
