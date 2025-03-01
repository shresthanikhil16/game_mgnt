// lib/features/history/presentation/view_model/history_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/history/domain/use_case/history_get_winners_usecase.dart';
import 'package:game_mgnt/features/history/presentation/view_model/history_event.dart';
import 'package:game_mgnt/features/history/presentation/view_model/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetWinnersUseCase getWinnersUseCase;

  HistoryBloc({required this.getWinnersUseCase}) : super(HistoryInitial()) {
    on<FetchWinners>((event, emit) async {
      emit(HistoryLoading());
      final result = await getWinnersUseCase(NoParams());
      result.fold(
        (failure) => emit(HistoryError(failure.message)),
        (winners) => emit(HistoryLoaded(winners)), // Check this line
      );
    });
  }
}
