import 'package:flutter/cupertino.dart';
import 'package:game_mgnt/app/app.dart';
import 'package:game_mgnt/app/di/di.dart';
import 'package:game_mgnt/core/network/hive_service.dart';
import 'package:game_mgnt/features/history/data/model/history_api_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive Database
  await HiveService.init();

  // Register Hive Adapters
  Hive.registerAdapter(HistoryApiModelAdapter());
  await Hive.openBox<HistoryApiModel>('historyBox');

  // Initialize Dependencies
  await initDependencies();

  // Run the app
  runApp(const App());
}
