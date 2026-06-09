import 'package:flowery/features/login/presentation/screens/login_screen.dart';

import 'package:flowery/features/forget_password/presentation/screens/forget_password_view.dart';
import 'package:flowery/features/forget_password/presentation/view_model/cubit/forget_password_view_model.dart';
import 'package:flowery/features/register/presentation/pages/register_screen.dart';
import 'package:flowery/features/home/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/forget_password/presentation/screens/email_verification_view.dart';
import '../../features/forget_password/presentation/screens/reset_new_password_view.dart';
import 'app_routes.dart';
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
              create: (context) => getIt<HomeViewModel>()
                ..doEvent(GetAllDataEvent()),
              child: const HomeView(),
            ),
          );

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
