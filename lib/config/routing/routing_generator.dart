import 'package:flutter/material.dart';
import 'package:flowery/features/app_section/presentation/view/app_section_view.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.appSection:
          return MaterialPageRoute(
            builder: (_) => const AppSectionView(),
          );

        // case AppRoutes.login:
        //   return MaterialPageRoute(
        //     builder: (_) => const LoginScreen(),
        //   );

        default:
          return unDefinedRoute();
      }
    } catch (e) {
      return errorRoute(e.toString());
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(
          child: Text('No Route Found'),
        ),
      ),
    );
  }

  static Route<dynamic> errorRoute(String error) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Error'),
        ),
        body: Center(
          child: Text(error),
        ),
      ),
    );
  }
}