import 'package:game_mgnt/features/chat/domain/entity/chat_entity.dart';
import 'package:game_mgnt/features/chat/domain/repository/chat_repository.dart';

class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase(this.repository);

  Future<MessageEntity> call(String receiver, String text) async {
    return repository.sendMessage(receiver, text);
  }
}
