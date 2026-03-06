import 'package:client/presentation/web/widgets/map_placeholder_widget.dart';
import 'package:client/presentation/web/widgets/package_table_widget.dart';
import 'package:client/presentation/web/widgets/tracking_events_widget.dart';
import 'package:client/presentation/web/widgets/web_header.dart';
import 'package:flutter/material.dart';

class MainTab extends StatelessWidget {
  const MainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho (Título e Pesquisa)
            const WebHeader(),

            const SizedBox(height: 24),

            // Zona dividida: Tabela (Esquerda) e Mapa/Eventos (Direita)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tabela de Encomendas (60% da largura)
                  Expanded(flex: 3, child: const PackageTableWidget()),

                  const SizedBox(width: 24),

                  // Mapa e Histórico (40% da largura)
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const MapPlaceholderWidget(),
                        const SizedBox(height: 24),
                        Expanded(child: const TrackingEventsWidget()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
