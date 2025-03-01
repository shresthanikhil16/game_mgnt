import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/history/domain/use_case/history_get_winners_usecase.dart';
import 'package:game_mgnt/features/profile/domain/use_case/get_profile_usecase.dart';
import 'package:game_mgnt/features/profile/presentation/view_model/profile_event.dart';
import 'package:game_mgnt/features/profile/presentation/view_model/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase}) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await getProfileUseCase(NoParams());
      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    });
  }
}
