import 'package:client/presentation/web/screens/tabs/main_tab.dart';
import 'package:client/presentation/web/screens/tabs/test_tab.dart';
import 'package:client/presentation/web/widgets/web_side_bar.dart';
import 'package:flutter/material.dart';

class WebDashboardScreen extends StatefulWidget {
  const WebDashboardScreen({super.key});

  @override
  State<WebDashboardScreen> createState() => _WebDashboardScreenState();
}

class _WebDashboardScreenState extends State<WebDashboardScreen> {
  // 1. Variável para guardar o índice da aba atual
  int _selectedIndex = 0;

  // 2. Lista de Widgets que representam cada "página"
  final List<Widget> _screens = [
    const MainTab(),       // Index 0: Dashboard
    const TestTab(),       // Index 1: Stats 
    // const StatsScreen(),   // Index 1 (terá de criar este widget)
    // const PackageScreen(), // Index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Row(
        children: [
          // Passamos a função de mudar de aba para a Sidebar
          WebSideBar(
            selectedIndex: _selectedIndex,
            onTabSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),

          // Mostramos apenas o widget correspondente ao index
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
