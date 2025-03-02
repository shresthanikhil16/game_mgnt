import 'package:game_mgnt/features/chat/domain/entity/chat_entity.dart';

abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsLoaded extends CommentsState {
  final List<MessageEntity> messages;

  CommentsLoaded(this.messages);
}

class CommentsError extends CommentsState {
  final String message;

  CommentsError(this.message);
}
