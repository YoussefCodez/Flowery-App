import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.login,
            style: theme.textTheme.labelLarge,
          ),
          titleSpacing: 0.0,
          leading: SizedBox(),
        ),
        body: Center(),
      ),
    );
  }
}
