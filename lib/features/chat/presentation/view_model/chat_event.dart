abstract class CommentsEvent {}

class SendMessageEvent extends CommentsEvent {
  final String receiver;
  final String text;

  SendMessageEvent(this.receiver, this.text);
}

class GetMessagesEvent extends CommentsEvent {
  final String userId;

  GetMessagesEvent(this.userId);
}
