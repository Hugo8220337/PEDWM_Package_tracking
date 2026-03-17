import 'package:client/data/models/tracking_event.dart';
import 'package:client/presentation/viewmodels/base_viewmodel.dart';

class MapScreenViewmodel extends BaseViewModel {
  Future<List<TrackingEvent>> fetchTrackingEvents() async {
    // Simula uma chamada de API para buscar os eventos de rastreamento
    await Future.delayed(const Duration(seconds: 2)); // Simula o tempo de resposta da API

    // Retorna uma lista de eventos de rastreamento (mocked)
    return [
      TrackingEvent(
        time: '11:30 PM',
        title: 'Package in transit',
        description: 'PT123456789 is in transit.',
        isCurrent: true,
      ),
      TrackingEvent(
        time: '10:00 AM',
        title: 'Package arrived at facility',
        description: 'PT123456789 arrived at the sorting facility.',
        isCurrent: false,
      ),
      TrackingEvent(
        time: '8:00 AM',
        title: 'Package picked up',
        description: 'PT123456789 was picked up by the courier.',
        isCurrent: false,
      ),
    ];
  }
}