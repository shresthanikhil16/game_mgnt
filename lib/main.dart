import 'package:flutter/material.dart';
import 'package:game_mgnt/view/dashboard_view.dart';
import 'package:game_mgnt/view/get_started_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const GetStartedView(),
        '/output': (context) => const GetStartedView(),
      },
    ),
  );
}
