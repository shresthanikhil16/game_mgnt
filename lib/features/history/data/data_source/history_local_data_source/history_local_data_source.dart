import 'package:game_mgnt/features/history/data/model/history_api_model.dart';
import 'package:hive/hive.dart';

class HistoryLocalDataSource {
  final Box<HistoryApiModel> historyBox;

  HistoryLocalDataSource(this.historyBox);

  Future<List<HistoryApiModel>> getWinners() async {
    return historyBox.values.toList();
  }

  Future<void> cacheWinners(List<HistoryApiModel> winners) async {
    await historyBox.clear();
    await historyBox.addAll(winners);
  }

  Future<void> clearWinners() async {
    await historyBox.clear();
  }
}
