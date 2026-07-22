import 'package:flowery/config/routing/app_routes.dart';
import 'package:flutter/material.dart';

import '../../featuers/notifiaction/presentation/view/notifcation_view/notification_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.notifiaction:
          return MaterialPageRoute(builder: (_) =>  NotificationPage());

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
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }

  static Route<dynamic> errorRoute(String error) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(child: Text(error)),
      ),
    );
  }
}
