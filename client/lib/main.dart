import 'package:client/config/dependency_injection.dart';
import 'package:client/core/constants/app_constants.dart';
import 'package:client/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter está pronto para executar código antes do runApp
  EasyLocalization.ensureInitialized(); // Garante que o EasyLocalization está pronto para uso

  // Chamar a inicialização do GetIt ANTES de arrancar a App
  DI.initialize();

  // Arrancar a aplicação
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('pt')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: const PackageTrackApp(),
    ),
  );
}

class PackageTrackApp extends StatelessWidget {
  const PackageTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,

      // Estas três linhas ligam o EasyLocalization ao MaterialApp
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      
      builder:
          FToastBuilder(), // Necessário para usar FlutterToast em toda a aplicação
      title: AppConstants.appName,
      theme: ThemeData(
        primaryColor: const Color(0xFF1976D2),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
      ),

      // main page
      // home: InitialScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
