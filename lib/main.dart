import 'package:flutter/material.dart';
import 'package:game_mgnt/view/dashboard_view.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardView(),
        '/output': (context) => const DashboardView(),
      },
    ),
  );
}