class MessageEntity {
  final String sender;
  final String receiver;
  final String text;
  final DateTime timestamp;

  MessageEntity({
    required this.sender,
    required this.receiver,
    required this.text,
    required this.timestamp,
  });
}
