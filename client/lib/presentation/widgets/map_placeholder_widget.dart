import 'package:flutter/material.dart';

class MapPlaceholderWidget extends StatelessWidget {
  const MapPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map, size: 50, color: Colors.grey),
              Text('Map / Route Component', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}