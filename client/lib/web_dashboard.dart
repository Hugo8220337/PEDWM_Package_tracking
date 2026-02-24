import 'package:flutter/material.dart';

// ==========================================
// ECRÃ PRINCIPAL WEB (LAYOUT)
// ==========================================
class WebDashboardScreen extends StatelessWidget {
  const WebDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Fundo cinzento claro
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Barra Lateral Esquerda (Sidebar)
          const WebSideBar(),
          
          // 2. Área Central de Conteúdo
          Expanded(
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
                        Expanded(
                          flex: 3,
                          child: const PackageTableWidget(),
                        ),
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
          ),
        ],
      ),
    );
  }
}

// ==========================================
// COMPONENTES DA UI WEB
// ==========================================

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

class WebHeader extends StatelessWidget {
  const WebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Web dashboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Container(
              width: 300,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.all(18)),
              child: const Text('Read more', style: TextStyle(color: Colors.white)),
            )
          ],
        )
      ],
    );
  }
}

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