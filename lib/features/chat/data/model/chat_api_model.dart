class ApiMessageModel {
  final String sender;
  final String receiver;
  final String text;
  final DateTime timestamp;

  ApiMessageModel({
    required this.sender,
    required this.receiver,
    required this.text,
    required this.timestamp,
  });

  factory ApiMessageModel.fromJson(Map<String, dynamic> json) {
    return ApiMessageModel(
      sender: json['sender'],
      receiver: json['receiver'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
