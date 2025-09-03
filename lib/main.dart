import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboaerd/core/helper/on_generate_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(onGenerateRoute: onGenerateRoutes);
  }
}
