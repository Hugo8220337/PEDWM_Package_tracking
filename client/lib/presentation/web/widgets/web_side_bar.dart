import 'package:flutter/material.dart';

class WebSideBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const WebSideBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          // ... (Header com logo mantém-se igual)

          _buildMenuItem(0, Icons.dashboard, 'Dashboard'),
          _buildMenuItem(1, Icons.bar_chart, 'Stats'),
          _buildMenuItem(2, Icons.inventory_2, 'Packages'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String label) {
    bool isSelected = selectedIndex == index;
    
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
      title: Text(label, style: TextStyle(
        color: isSelected ? Colors.blue : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      )),
      tileColor: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      onTap: () => onTabSelected(index), // Chama a função que passámos no construtor
    );
  }
}