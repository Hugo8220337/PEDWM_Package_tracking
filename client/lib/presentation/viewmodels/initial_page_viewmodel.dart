import 'package:client/core/constants/api_constants.dart';
import 'package:client/presentation/viewmodels/base_viewmodel.dart';
import 'package:dio/dio.dart';

class InitialPageViewmodel extends BaseViewModel {
  final Dio dio;

  InitialPageViewmodel({required this.dio});

  Future<void> submitTrackingCode(String code) async {
    setLoading(true);
    clearError();

    try {
      if (code == "Let there be light") {
        await createPackage();
        // router.go('/map', extra: {'trackingCode': "TODO: Passar o código real aqui"}); // TODO
      } else {
        // setError('Invalid tracking code');
        // Simula um processo de validação e busca de dados
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch(e) {
      setError('An error occurred: $e');
    }
     finally {
      setLoading(false);
    }
  }

  Future<void> createPackage() async {
    final response = await dio.post(ApiConstants.createParcelEndpoint);
    if (response.statusCode == 200) {
      // Sucesso
    } else {
      setError('Failed to create package');
    }
  }
}
