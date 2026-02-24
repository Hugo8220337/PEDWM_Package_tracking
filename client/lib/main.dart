import 'package:client/mobile_dashboard.dart';
import 'package:client/web_dashboard.dart';
import 'package:flutter/material.dart';

// Importa os teus ficheiros aqui (ou cola as classes abaixo se estiveres a testar num só ficheiro)
// import 'mobile_list_screen.dart';
// import 'web_dashboard.dart';

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
      // O nosso "gestor de trânsito" entra aqui!
      home: const ResponsiveLayout(
        mobileBody: PackageListScreen(), // O primeiro código que te dei
        webBody: WebDashboardScreen(),   // O segundo código que te dei
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