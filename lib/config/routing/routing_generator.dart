import 'package:flowery/featuers/home/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        // case AppRoutes.login:
        //   return MaterialPageRoute(
        //     builder: (_) => const LoginScreen(),
        //   );

        case AppRoutes.homeView:
          return MaterialPageRoute(
            builder: (_) => const HomeView(),
          );

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