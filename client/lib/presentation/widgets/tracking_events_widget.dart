import 'package:client/data/models/tracking_event.dart';
import 'package:client/presentation/widgets/tracking_event_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TrackingEventsWidget extends StatelessWidget {
  final List<TrackingEvent> events;

  const TrackingEventsWidget({super.key, required this.events});

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
            Text(
              'tracking_events'.tr(context: context),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildTrackingEvents(),
          ],
        ),
      ),
    );
  }

    Widget _buildTrackingEvents() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return TrackingEventItem(event: event, isLast: index == events.length - 1);
      },
    );
  }
}
