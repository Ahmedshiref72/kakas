import 'package:flutter/material.dart';

import '../../auth/presentation/screens/login/login_view.dart';
import '../../home/presentation/screens/home/home_view.dart';
import '../../home/presentation/screens/home/update_product.dart';
import '../../home/presentation/screens/home/upload_product.dart';
import '../../splash/presentation/screens/splash_screen.dart';
import '../local/shared_preference.dart';
import 'app_strings.dart';
import 'constants_manager.dart';

class Routes {
  static const String home = "/";
  static const String loginRoute = "/loginRoute";
  static const String homeScreenRoute = "/homeScreen";
  static const String uploadscreenRoute = "/uploadscreen";
  static const String editProductRoute = '/edit_product';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) =>
         SplashView()  );
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
        case Routes.homeScreenRoute:
      return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.uploadscreenRoute:
      return MaterialPageRoute(builder: (_) => const UploadProductScreen());


      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.wrongScreen),
            ),
            body: const Center(child: Text(AppStrings.routeNotFound)),
          ),
    );
  }
}
