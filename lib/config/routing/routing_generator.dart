import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/products_details/presentation/pages/products_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AppRoutes.productDetails:
          // final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => const ProductsDetailsScreen(
              imageUrl: '',
              title: ' Pink Rose ',
              price: 1500,
              isdescount: false,
              oldPrice: 0.0,
              discount: 0.0,
              sold: 0,
              quantity: 15,
              images: [],
              //               images: List<String>.from(
              //   args[CategoriesValues.images],

              // ),
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
