import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/general_cubit/general_state.dart';
import 'package:flowery/config/general_cubit/local_cubit.dart';
import 'package:flowery/config/helpers/bloc/bloc_observer.dart';
import 'package:flowery/config/helpers/shared_pref.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_generator.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routing/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Bloc.observer = MyBlocObserver();
  await configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => getIt<LocaleThemeCubit>(),
      child: FloweryApp(),
    ),
  );
}

class FloweryApp extends StatelessWidget {
  FloweryApp({super.key});

  final isRememberMe = getIt<SharedPrefHelper>().getString(Apikeys.userId);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LocaleThemeCubit, LocaleThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flowery',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              onGenerateRoute: RouteGenerator.getRoute,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              //  darkTheme: AppTheme.darkTheme,
              // themeMode: state.themeMode,
              initialRoute: isRememberMe == "true"
                  ? AppRoutes.home
                  : AppRoutes.login,
            );
          },
        );
      },
    );
  }
}
