import 'package:client/config/dependency_injection.dart';
import 'package:client/core/constants/app_constants.dart';
import 'package:client/presentation/views/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  DI.initialize();
  runApp(const PackageTrackApp());
}

class PackageTrackApp extends StatelessWidget {
  const PackageTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(), // Necessário para usar FlutterToast em toda a aplicação
      title: AppConstants.appName,
      theme: ThemeData(
        primaryColor: const Color(0xFF1976D2),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
      ),

      // main page
      home: InitialScreen(),

      debugShowCheckedModeBanner: false,
    );
  }
}