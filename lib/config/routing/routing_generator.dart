

import 'package:flowery/features/categories/presentation/screens/categories_screen.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
