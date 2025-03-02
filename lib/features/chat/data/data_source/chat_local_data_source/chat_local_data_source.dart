import 'package:game_mgnt/features/chat/data/model/chat_hive_model.dart';
import 'package:hive/hive.dart';

class LocalMessageDataSource {
  final Box<HiveMessageModel> _messageBox;

  LocalMessageDataSource(this._messageBox);

  Future<void> saveMessages(List<HiveMessageModel> messages) async {
    await _messageBox.clear();
    await _messageBox.addAll(messages);
  }

  List<HiveMessageModel> getMessages() {
    return _messageBox.values.toList();
  }
}
