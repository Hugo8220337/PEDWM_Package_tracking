import 'dart:ui';

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
