import 'package:flutter/material.dart';

class WebSideBar extends StatelessWidget {
  const WebSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.blue, size: 28),
                SizedBox(width: 12),
                Text('PackageTrack', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.blue),
            title: const Text('Dashboard', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            tileColor: Colors.blue.withOpacity(0.1),
            onTap: () {},
          ),
          ListTile(leading: const Icon(Icons.bar_chart), title: const Text('Stats'), onTap: () {}),
          ListTile(leading: const Icon(Icons.inventory_2), title: const Text('Packages'), onTap: () {}),
          ListTile(leading: const Icon(Icons.person), title: const Text('User'), onTap: () {}),
          ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), onTap: () {}),
        ],
      ),
    );
  }
}