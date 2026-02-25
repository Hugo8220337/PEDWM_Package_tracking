import 'package:client/presentation/mobile/screens/mobile_dashboard_screen.dart';
import 'package:client/presentation/web/screens/web_dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PackageTrackApp());
}

class PackageTrackApp extends StatelessWidget {
  const PackageTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PackageTrack',
      theme: ThemeData(
        primaryColor: const Color(0xFF1976D2),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
      ),

      // "gestor de trânsito"
      home: const ResponsiveLayout(
        mobileBody: PackageListScreen(),
        webBody: WebDashboardScreen(), 
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// COMPONENTE RESPONSIVO (O "Cérebro" do Layout)
// ==========================================
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget webBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.webBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Se a largura do ecrã for menor que 800 pixeis, assumimos que é Mobile/Tablet pequeno
        if (constraints.maxWidth < 800) {
          return mobileBody;
        } 
        // Se for maior que 800 pixeis, mostramos o Dashboard Web completo
        else {
          return webBody;
        }
      },
    );
  }
}