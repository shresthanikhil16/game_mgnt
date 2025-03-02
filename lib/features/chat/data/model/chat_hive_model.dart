import 'package:hive/hive.dart';

part 'chat_hive_model.g.dart'; // Run `flutter packages pub run build_runner build`

@HiveType(typeId: 0)
class HiveMessageModel extends HiveObject {
  @HiveField(0)
  final String sender;
  @HiveField(1)
  final String receiver;
  @HiveField(2)
  final String text;
  @HiveField(3)
  final DateTime timestamp;

  HiveMessageModel({
    required this.sender,
    required this.receiver,
    required this.text,
    required this.timestamp,
  });
}
