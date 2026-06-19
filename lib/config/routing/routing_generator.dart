import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/featuers/web_view/presentation/screen/test_term_screen.dart';
import 'package:flowery/featuers/web_view/presentation/screen/web_view_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        // case AppRoutes.mainProfile:
        //   return MaterialPageRoute(builder: (_) => const MainProfileView());

        case AppRoutes.testTerm:
          return MaterialPageRoute(
            builder: (_) => const TestTermScreen(),
          );

        case AppRoutes.termsAndConditions:
          return MaterialPageRoute(
            builder: (_) => const WebViewScreen(
              url: 'https://elevate-flutter-team.github.io/flower_app_web_views/terms.html',
              title: 'Terms & Conditions',
            ),
          );

        case AppRoutes.aboutUs:
          return MaterialPageRoute(
            builder: (_) => const WebViewScreen(
              url: 'https://elevate-flutter-team.github.io/flower_app_web_views/about.html',
              title: 'About Us',
            ),
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
