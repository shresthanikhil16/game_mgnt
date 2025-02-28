import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/matchup/domain/use_case/matchups_usecase.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_event.dart';
import 'package:game_mgnt/features/matchup/presentation/view_model/matchups_state.dart';

class MatchupBloc extends Bloc<MatchupEvent, MatchupState> {
  final GetMatchupsUseCase getMatchupsUseCase;
  final GetUniqueTournamentsUseCase getUniqueTournamentsUseCase;

  MatchupBloc({
    required this.getMatchupsUseCase,
    required this.getUniqueTournamentsUseCase,
  }) : super(MatchupInitial()) {
    on<FetchMatchups>((event, emit) async {
      emit(MatchupLoading());
      final result = await getMatchupsUseCase.execute(event.tournament);
      result.fold(
        (failure) => emit(MatchupError(failure.message)),
        (matchups) {
          print("Matchups: $matchups");
          print("Matchups Type: ${matchups.runtimeType}");
          emit(MatchupLoaded(matchups));
        },
      );
    });

    on<FetchUniqueTournaments>((event, emit) async {
      emit(MatchupLoading());
      final result = await getUniqueTournamentsUseCase.execute();
      result.fold(
        (failure) => emit(MatchupError(failure.message)),
        (tournaments) => emit(UniqueTournamentsLoaded(tournaments)),
      );
    });
  }
}
