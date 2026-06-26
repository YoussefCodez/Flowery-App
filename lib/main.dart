import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/general_cubit/general_state.dart';
import 'package:flowery/config/general_cubit/local_cubit.dart';
import 'package:flowery/config/helpers/bloc/bloc_observer.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_generator.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'featuers/notification_service/notification_service.dart';
import 'firebase_options.dart';
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await configureDependencies();

  final notificationService = getIt<NotificationService>();
  await notificationService.requestPermission();
  await notificationService.getToken();
  await notificationService.initLocalNotifications();
  notificationService.initListeners();

  runApp(
    BlocProvider(
      create: (context) => getIt<LocaleThemeCubit>(),
      child: const FloweryApp(),
    ),
  );
}

class FloweryApp extends StatelessWidget {
  const FloweryApp({super.key});

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
              initialRoute: AppRoutes.mainProfile,
            );
          },
        );
      },
    );
  }
}
