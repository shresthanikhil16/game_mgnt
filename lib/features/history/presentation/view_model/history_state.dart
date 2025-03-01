import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> winners;

  HistoryLoaded(this.winners);

  @override
  List<Object> get props => [winners];
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
