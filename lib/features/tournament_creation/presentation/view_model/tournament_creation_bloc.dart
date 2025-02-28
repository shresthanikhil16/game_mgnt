// tournament_bloc.dart (Canvas 10 continued)
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/tournament_creation/data/repository/tournament_creation_remote_repository.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_event.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  final TournamentRepository repository;

  TournamentBloc(this.repository) : super(TournamentInitial()) {
    on<CreateTournament>((event, emit) async {
      emit(TournamentLoading());
      final result = await repository.createTournament(event.tournament);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (_) => emit(TournamentSuccess("Tournament created successfully")),
      );
    });

    on<FetchTournaments>((event, emit) async {
      emit(TournamentLoading());
      final result = await repository.getTournamentsByGame(event.game);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (tournaments) => emit(TournamentLoaded(tournaments)),
      );
    });

    on<FetchTournamentNames>((event, emit) async {
      emit(TournamentLoading());
      final result = await repository.getTournamentNamesByGame(event.game);
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (names) => emit(TournamentNamesLoaded(names)),
      );
    });

    on<FetchGameList>((event, emit) async {
      emit(TournamentLoading());
      final result = await repository.getGameList();
      result.fold(
        (failure) => emit(TournamentError(failure.message)),
        (games) => emit(GameListLoaded(games)),
      );
    });
  }
}
