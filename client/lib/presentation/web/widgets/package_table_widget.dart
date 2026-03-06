import 'package:client/data/models/test_http_model.dart';
import 'package:client/presentation/web/viewmodels/sample_viewmodel.dart';
import 'package:flutter/material.dart';

class PackageTableWidget extends StatefulWidget {
  const PackageTableWidget({super.key});

  @override
  State<PackageTableWidget> createState() => _PackageTableWidgetState();
}

class _PackageTableWidgetState extends State<PackageTableWidget> {
  SampleViewmodel viewmodel = SampleViewmodel();

  late Future<List<TestHttpModel>> randomWordsFuture;

  @override
  void initState() {
    super.initState();

    randomWordsFuture = viewmodel.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: FutureBuilder<List<TestHttpModel>>(
        future: randomWordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No data found'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];

              final code = item.randomWord;
              final isDelivered =
                  index % 2 != 0; // e.g. item.status == 'Delivered'
              final date = 'Mon, Sep 18th'; // e.g. item.formattedDate

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        code,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDelivered
                            ? Colors.green.withOpacity(0.1)
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isDelivered ? 'Delivered' : 'In Transit',
                        style: TextStyle(
                          color: isDelivered ? Colors.green : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Text(date, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
