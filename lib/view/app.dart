import 'package:flutter/material.dart';
import 'package:game_mgnt/core/app_theme/app_theme.dart';
import 'package:game_mgnt/view/get_started_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GetStartedView(),
      theme: getApplicationTheme(),
    );
  }
}
