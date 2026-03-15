import 'package:client/presentation/widgets/my_app_bar.dart';
import 'package:client/presentation/widgets/tracking_events_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildMainContent()],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildMapSection(),
          ),
          const SizedBox(width: 24),
          const Expanded(
            flex: 2,
            child: TrackingEventsWidget(),
          ),
        ],
      ),
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
            initialCenter: LatLng(38.7223, -9.1393), // Exemplo: Lisboa
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
