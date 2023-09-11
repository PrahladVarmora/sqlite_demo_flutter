import 'package:silver_touch_task/modules/dashboard/view/screen_dashboard.dart';
import 'package:silver_touch_task/modules/splash/view/screen_splash.dart';

import 'common_import.dart';

/// > RouteGenerator is a class that generates routes for the application
/// It's a class that generates routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.routesSplash:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
      case AppRoutes.routesScreenDashboard:
        return MaterialPageRoute(
            builder: (_) => const ScreenDashboard(),
            settings: const RouteSettings(name: AppRoutes.routesScreenDashboard));
      default:
        return MaterialPageRoute(
            builder: (_) => const ScreenSplash(),
            settings: const RouteSettings(name: AppRoutes.routesSplash));
    }
  }
}
