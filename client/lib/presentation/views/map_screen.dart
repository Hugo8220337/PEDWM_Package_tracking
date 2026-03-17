import 'package:client/config/dependency_injection.dart';
import 'package:client/data/models/tracking_event.dart';
import 'package:client/presentation/viewmodels/map_screen_viewmodel.dart';
import 'package:client/presentation/widgets/my_app_bar.dart';
import 'package:client/presentation/widgets/tracking_events_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DI.instance<MapScreenViewmodel>(),
      
      child: Builder(
        builder: (newContext) {
          return Scaffold(
            appBar: MyAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildMainContent(newContext)],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildMapSection()),
          const SizedBox(width: 35),
          _buildTrackingEventsSection(context),
        ],
      ),
    );
  }

  Widget _buildTrackingEventsSection(BuildContext context) {
    final viewmodel = context.watch<MapScreenViewmodel>();

    return FutureBuilder<List<TrackingEvent>>(
      future: viewmodel.fetchTrackingEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading tracking events'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tracking events available'));
        } else {
          return TrackingEventsWidget(events: snapshot.data!);
        }
      },
    );
  }

  // O componente de Mapa
  Widget _buildMapSection() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(38.7223, -9.1393), // TODO Exemplo: Lisboa
            initialZoom: 13.0,
          ),
          children: [
            // 1. A camada visual do mapa (Tiles)
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.teuapp.client',
            ),

            // 2. A camada de marcadores (Pins)
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(38.7223, -9.1393),
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
