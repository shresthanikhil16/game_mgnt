import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWinners extends HistoryEvent {}
