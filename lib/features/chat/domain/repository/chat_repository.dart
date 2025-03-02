import 'package:game_mgnt/features/chat/domain/entity/chat_entity.dart';

abstract class MessageRepository {
  Future<MessageEntity> sendMessage(String receiver, String text);
  Future<List<MessageEntity>> getMessages(String userId);
}
