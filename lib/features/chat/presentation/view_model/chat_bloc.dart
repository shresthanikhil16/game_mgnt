import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/chat/domain/usecase/get_message_usecase.dart';
import 'package:game_mgnt/features/chat/domain/usecase/sned_message_usecase.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_event.dart';
import 'package:game_mgnt/features/chat/presentation/view_model/chat_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;

  CommentsBloc({
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
  }) : super(CommentsInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<GetMessagesEvent>(_onGetMessages);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    try {
      await sendMessageUseCase(event.receiver, event.text);
      add(GetMessagesEvent(event.receiver)); // Refresh messages
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }

  Future<void> _onGetMessages(
      GetMessagesEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    try {
      final messages = await getMessagesUseCase(event.userId);
      emit(CommentsLoaded(messages));
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }
}
