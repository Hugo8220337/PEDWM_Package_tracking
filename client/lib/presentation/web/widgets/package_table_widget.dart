import 'package:flutter/material.dart';

class PackageTableWidget extends StatelessWidget {
  const PackageTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          bool isDelivered = index % 2 != 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Icon(Icons.check_box_outline_blank, color: Colors.grey),
                const SizedBox(width: 16),
                const Expanded(child: Text('PT123456789', style: TextStyle(fontWeight: FontWeight.bold))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDelivered ? Colors.green.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isDelivered ? 'Delivered' : 'In Transit',
                    style: TextStyle(color: isDelivered ? Colors.green : Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 32),
                const Text('Mon, Sep 18th', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}