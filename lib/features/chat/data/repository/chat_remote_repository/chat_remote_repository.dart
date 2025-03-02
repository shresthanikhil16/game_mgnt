import 'package:game_mgnt/features/chat/data/data_source/chat_remote_data_source/chat_remote_data_source.dart';
import 'package:game_mgnt/features/chat/data/model/chat_api_model.dart';
import 'package:game_mgnt/features/chat/domain/entity/chat_entity.dart';
import 'package:game_mgnt/features/chat/domain/repository/chat_repository.dart';

class RemoteMessageRepository implements MessageRepository {
  final RemoteMessageDataSource _dataSource;

  RemoteMessageRepository(this._dataSource);

  @override
  Future<MessageEntity> sendMessage(String receiver, String text) async {
    final apiMessage = await _dataSource.sendMessage(receiver, text);
    return apiMessage.toEntity();
  }

  @override
  Future<List<MessageEntity>> getMessages(String userId) async {
    final apiMessages = await _dataSource.getMessages(userId);
    return apiMessages.map((apiMessage) => apiMessage.toEntity()).toList();
  }
}

extension ApiMessageModelExtension on ApiMessageModel {
  MessageEntity toEntity() {
    return MessageEntity(
      sender: sender,
      receiver: receiver,
      text: text,
      timestamp: timestamp,
    );
  }
}
