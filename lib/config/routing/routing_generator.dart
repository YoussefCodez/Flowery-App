import 'package:flowery/core/widgets/main_layout.dart';
import 'package:flowery/features/cart/presentation/screens/cart_screen.dart';
import 'package:flowery/features/login/presentation/screens/login_screen.dart';
import 'package:flowery/features/forget_password/presentation/screens/forget_password_view.dart';
import 'package:flowery/features/forget_password/presentation/view_model/cubit/forget_password_view_model.dart';
import 'package:flowery/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:flowery/features/register/presentation/pages/register_screen.dart';
import 'package:flowery/features/home/presentation/screens/home_view.dart';
import 'package:flowery/features/categories/presentation/screens/categories_screen.dart';
import 'package:flowery/features/occasions/presentation/screens/occasions_screen.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/features/best_seller/presentation/screens/best_seller_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/forget_password/presentation/screens/email_verification_view.dart';
import '../../features/forget_password/presentation/screens/reset_new_password_view.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/home/presentation/view_model/home_event.dart';
import '../di/injectable_config.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());

      case AppRoutes.emailVerification:
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
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<HomeViewModel>()..doEvent(GetAllDataEvent()),
            child: const HomeView(),
          ),
        );

      case AppRoutes.categories:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(showBackButton: true),
        );

      case AppRoutes.mainLayout:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    getIt<HomeViewModel>()..doEvent(GetAllDataEvent()),
              ),
            ],
            child: const MainLayout(),
          ),
        );

      case AppRoutes.bestSeller:
        return MaterialPageRoute(builder: (_) => const BestSellerScreen());

      case AppRoutes.occasions:
        return MaterialPageRoute(builder: (_) => OccasionsScreen());

      case AppRoutes.productDetails:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailsScreen(
            imageUrl: '',
            title: ' Pink Rose ',
            price: 1500,
            isdescount: false,
            oldPrice: 0.0,
            discount: 0.0,
            sold: 0,
            quantity: 15,
            images: [], description: '',
            id: '',
          ),
        );

      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
        
      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: const Text('No Route Found')),
      body: const Center(child: Text('No Route Found')),
    ),
  );
}
