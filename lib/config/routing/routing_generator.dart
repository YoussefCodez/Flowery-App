import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/best_seller/presentation/screens/best_seller_screen.dart';
import 'package:flowery/features/products_details/presentation/pages/products_details_screen.dart';
import 'package:flowery/features/home/presentation/home.screen.dart';
import 'package:flowery/features/login/presentation/screens/login_screen.dart';
import 'package:flowery/features/forget_password/presentation/screens/forget_password_view.dart';
import 'package:flowery/features/forget_password/presentation/view_model/cubit/forget_password_view_model.dart';
import 'package:flowery/features/register/presentation/pages/register_screen.dart';
import 'package:flowery/features/occasions/presentation/screens/occasions_screen.dart';
import 'package:flowery/features/categories/presentation/screens/categories_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/forget_password/presentation/screens/email_verification_view.dart';
import '../../features/forget_password/presentation/screens/reset_new_password_view.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        // case AppRoutes.productDetails:
        //   final args = settings.arguments as Map<String, dynamic>;
        //   return MaterialPageRoute(
        //     builder: (_) => ProductsDetailsScreen(
        //       imageUrl: args["image"],
        //       title: args["title"],
        //       price: args["price"],
        //       isdescount: false,
        //       oldPrice: 0,
        //       discount: args["discount"],
        //       sold: args["sold"],
        //       quantity: args["quantity"],
        //       images: args["images"],
        //     ),
        //   );

        case AppRoutes.productDetails:
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => ProductsDetailsScreen(
              imageUrl: args["image"] ?? "",
              title: args["title"] ?? "",
              price: (args["price"] as num?)?.toDouble() ?? 0.0,
              isdescount:
                  args["hasDiscount"] ??
                  false, // Map card's hasDiscount to screen's isdescount
              oldPrice: (args["oldPrice"] as num?)?.toDouble() ?? 0.0,
              discount: (args["discount"] as num?)?.toDouble() ?? 0.0,
              sold: args["sold"] ?? 0,
              quantity: args["quantity"] ?? 0,
              images: List<String>.from(args["images"] ?? []),
              description: args["description"] ?? "",
            
            ),
          );

        case AppRoutes.register:
          return MaterialPageRoute(builder: (_) => const RegisterScreen());

        case AppRoutes.home:
          return MaterialPageRoute(builder: (_) => const HomeScreen());

        case AppRoutes.forgetPassword:
          // ForgetPasswordView owns the Cubit — it creates it internally.
          return MaterialPageRoute(builder: (_) => const ForgetPasswordView());

        case AppRoutes.emailVerification:
          // The Cubit is passed as an argument from ForgetPasswordView's listener.
          // BlocProvider.value shares the existing instance without taking ownership
          // (it won't close the Cubit when this route is popped).
          final cubit = settings.arguments as ForgetPasswordViewModel;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: const EmailVerificationView(),
            ),
          );

        case AppRoutes.resetPassword:
          final cubit = settings.arguments as ForgetPasswordViewModel;
          return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: cubit, child: ResetNewPasswordView()),
          );

        case AppRoutes.login:
          return MaterialPageRoute(builder: (_) => LoginScreen());

        case AppRoutes.occasions:
          return MaterialPageRoute(builder: (_) => OccasionsScreen());

        case AppRoutes.categories:
          return MaterialPageRoute(builder: (_) => const CategoriesScreen());

        case AppRoutes.bestSeller:
          return MaterialPageRoute(builder: (_) => const BestSellerScreen());

        case AppRoutes.homeView:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<HomeViewModel>()
                ..doEvent(GetAllDataEvent()),
              child: const HomeView(),
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
