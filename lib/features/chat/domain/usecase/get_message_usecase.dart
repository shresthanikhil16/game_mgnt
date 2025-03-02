import 'package:game_mgnt/features/chat/domain/entity/chat_entity.dart';
import 'package:game_mgnt/features/chat/domain/repository/chat_repository.dart';

class GetMessagesUseCase {
  final MessageRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<MessageEntity>> call(String userId) async {
    return repository.getMessages(userId);
  }
}
