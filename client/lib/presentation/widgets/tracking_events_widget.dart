import 'package:flutter/material.dart';

class TrackingEventsWidget extends StatelessWidget {
  const TrackingEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tracking events', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('11:30 PM', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            Icon(Icons.circle, size: 12, color: index == 0 ? Colors.blue : Colors.grey),
                            if (index < 3) Container(width: 2, height: 30, color: Colors.grey[300]),
                          ],
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tracking event', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('PT123456789 is in transit.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}