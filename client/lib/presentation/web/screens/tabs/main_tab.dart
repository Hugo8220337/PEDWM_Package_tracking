import 'package:client/presentation/web/widgets/package_table_widget.dart';
import 'package:client/presentation/web/widgets/tracking_events_widget.dart';
import 'package:client/presentation/web/widgets/web_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Importa o flutter_map

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  final LatLng _center = const LatLng(-23.5505, -46.6333); // Exemplo: São Paulo

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WebHeader(),
            const SizedBox(height: 24),
            _buildMainContent(), // Método principal de layout
          ],
        ),
      ),
    );
  }

  // Divide a tela entre Tabela e a Coluna da Direita
  Widget _buildMainContent() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: const PackageTableWidget()),
          const SizedBox(width: 24),
          Expanded(flex: 2, child: _buildSidePanel()),
        ],
      ),
    );
  }

  // Painel lateral com Mapa e Eventos
  Widget _buildSidePanel() {
    return Column(
      children: [
        _buildMapSection(), // Onde o mapa reside
        const SizedBox(height: 24),
        Expanded(child: const TrackingEventsWidget()),
      ],
    );
  }

  // O componente de Mapa propriamente dito
  Widget _buildMapSection() {
    return SizedBox(
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
