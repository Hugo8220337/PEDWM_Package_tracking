import 'package:client/presentation/views/tabs/main_tab.dart';
import 'package:client/presentation/widgets/web_side_bar.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 1. Variável para guardar o índice da aba atual
  int _selectedIndex = 0;

  // 2. Lista de Widgets que representam cada "página"
  final List<Widget> _screens = [
    const MainTab(),       // Index 0: Dashboard
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
