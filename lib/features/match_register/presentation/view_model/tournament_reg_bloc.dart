import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/match_register/domain/use_case/usecase.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_event.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_state.dart';

class TournamentRegistrationBloc
    extends Bloc<TournamentRegistrationEvent, TournamentRegistrationState> {
  final RegisterPlayerUseCase registerPlayerUseCase;
  final GetRegisteredPlayersUseCase getRegisteredPlayersUseCase;
  final GetTournamentNamesUseCase getTournamentNamesUseCase;
  final GetAllGameNamesUseCase getAllGameNamesUseCase; // New use case

  TournamentRegistrationBloc({
    required this.registerPlayerUseCase,
    required this.getRegisteredPlayersUseCase,
    required this.getTournamentNamesUseCase,
    required this.getAllGameNamesUseCase, // Add this line
  }) : super(TournamentRegistrationInitial()) {
    on<RegisterPlayer>((event, emit) async {
      emit(TournamentRegistrationLoading());
      final result = await registerPlayerUseCase.execute(event.player);
      result.fold(
        (failure) => emit(TournamentRegistrationError(failure.message)),
        (_) => emit(TournamentRegistrationSuccess()),
      );
    });

    on<FetchRegisteredPlayers>((event, emit) async {
      emit(TournamentRegistrationLoading());
      final result = await getRegisteredPlayersUseCase.execute();
      result.fold(
        (failure) => emit(TournamentRegistrationError(failure.message)),
        (players) => emit(RegisteredPlayersLoaded(players)),
      );
    });

    on<FetchTournamentNames>((event, emit) async {
      emit(TournamentRegistrationLoading());
      final result = await getTournamentNamesUseCase.execute(event.game);
      result.fold(
        (failure) => emit(TournamentRegistrationError(failure.message)),
        (names) => emit(TournamentNamesLoaded(names)),
      );
    });

    on<FetchAllGameNames>((event, emit) async {
      emit(TournamentRegistrationLoading());
      final result = await getAllGameNamesUseCase.execute();
      result.fold(
        (failure) => emit(TournamentRegistrationError(failure.message)),
        (names) => emit(AllGameNamesLoaded(names)),
      );
    });
  }
}
