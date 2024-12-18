import 'package:flutter/material.dart';
import 'package:game_mgnt/core/app_theme/app_theme.dart';
import 'package:game_mgnt/view/get_started_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => const GetStartedView(),
        '/output': (context) => const GetStartedView(),
      },
    ),
  );
}
