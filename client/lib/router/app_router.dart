import 'package:client/core/constants/routes_constants.dart';
import 'package:client/presentation/views/initial_screen.dart';
import 'package:client/presentation/views/map_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesConstants.initialScreenRoute,
    routes: [
      GoRoute(
        name: RoutesConstants.initialScreen,
        path: RoutesConstants.initialScreenRoute,
        builder: (context, state) => const InitialScreen(),
      ),
      GoRoute(
        name: RoutesConstants.mapScreen,
        path: RoutesConstants.mapScreenRoute,
        builder: (context, state) {
          final packageId = state.pathParameters['packageId']!;
          return MapScreen(packageId: packageId);
        },
      ),
    ],
  );
}