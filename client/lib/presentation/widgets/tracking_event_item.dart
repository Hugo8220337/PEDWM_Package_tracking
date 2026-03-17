import 'package:client/data/models/tracking_event.dart';
import 'package:flutter/material.dart';

class TrackingEventItem extends StatelessWidget {
  final TrackingEvent event;
  final bool isLast;

  const TrackingEventItem({super.key, required this.event, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: event.isCurrent ? Colors.blue : Colors.grey,
              ),
              if (!isLast)
                Container(width: 2, height: 30, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  event.description,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}