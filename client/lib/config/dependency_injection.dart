import 'package:client/config/dio_client.dart';
import 'package:client/presentation/viewmodels/initial_page_viewmodel.dart';
import 'package:client/presentation/viewmodels/map_screen_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DI {
  static late GetIt instance;
  
  static void initialize() {
    instance = GetIt.instance;
    
    // --- Core Services ---
    instance.registerLazySingleton<Dio>(() => DioClient.build());
    
    // Data sources
    // instance.registerLazySingleton<AuthRemoteDataSource>(
    //   () => AuthRemoteDataSourceImpl(instance()),
    // );
    
    // Repositories  
    // instance.registerLazySingleton<AuthRepository>(
    //   () => AuthRepositoryImpl(instance()),
    // );
    
    // Use cases
    // instance.registerLazySingleton(() => LoginUseCase(instance()));
    
    // ViewModels
    // Uso o factory para criar uma nova instância sempre que pedir, invés de colocar um singleton e estar sempre em memória
    instance.registerFactory(() => InitialPageViewmodel(
      dio: instance<Dio>() // Injetar a dependência do Dio no ViewModel
    ));

    instance.registerFactory(() => MapScreenViewmodel());

  }
}