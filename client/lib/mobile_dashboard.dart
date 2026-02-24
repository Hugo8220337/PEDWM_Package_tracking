import 'package:flutter/material.dart';

// ==========================================
// MODELO DE DADOS (MOCK)
// ==========================================
class Package {
  final String trackingNumber;
  final String location;
  final String status;
  final double progress;
  final Color statusColor;

  Package({
    required this.trackingNumber,
    required this.location,
    required this.status,
    required this.progress,
    required this.statusColor,
  });
}

// ==========================================
// ECRÃ PRINCIPAL MOBILE
// ==========================================
class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  int _currentIndex = 1; // Começa no separador da "Lista" (índice 1)

  // Lista estática para desenhar a interface antes de ligar ao Golang
  final List<Package> myPackages = [
    Package(
      trackingNumber: 'PT123456789',
      location: 'Lisboa, PT',
      status: 'In Transit',
      progress: 0.6,
      statusColor: Colors.blue,
    ),
    Package(
      trackingNumber: 'PT987654321',
      location: 'Porto, PT',
      status: 'Delivered',
      progress: 1.0,
      statusColor: Colors.green,
    ),
    Package(
      trackingNumber: 'PT112233445',
      location: 'Coimbra, PT',
      status: 'In transit',
      progress: 0.3,
      statusColor: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Packages',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: myPackages.length,
        itemBuilder: (context, index) {
          // Aqui chamamos o widget do cartão para cada encomenda
          return PackageCard(package: myPackages[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1976D2),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Track'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

// ==========================================
// COMPONENTE DO CARTÃO DE ENCOMENDA
// ==========================================
class PackageCard extends StatelessWidget {
  final Package package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  package.trackingNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.local_shipping, color: Colors.grey, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  package.location,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  package.status,
                  style: TextStyle(
                    color: package.statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Barra de progresso animada baseada no estado da encomenda
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: package.progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(package.statusColor),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}