import 'package:game_mgnt/features/chat/data/data_source/chat_local_data_source/chat_local_data_source.dart';
import 'package:game_mgnt/features/chat/data/model/chat_hive_model.dart';
import 'package:game_mgnt/features/chat/domain/entity/chat_entity.dart';

class LocalMessageRepository {
  final LocalMessageDataSource localDataSource;

  LocalMessageRepository(this.localDataSource);

  Future<void> saveMessages(List<MessageEntity> messages) async {
    final hiveMessages = messages
        .map((message) => HiveMessageModel(
              sender: message.sender,
              receiver: message.receiver,
              text: message.text,
              timestamp: message.timestamp,
            ))
        .toList();
    await localDataSource.saveMessages(hiveMessages);
  }

  List<MessageEntity> getMessages() {
    return localDataSource
        .getMessages()
        .map((hiveMessage) => MessageEntity(
              sender: hiveMessage.sender,
              receiver: hiveMessage.receiver,
              text: hiveMessage.text,
              timestamp: hiveMessage.timestamp,
            ))
        .toList();
  }
}
