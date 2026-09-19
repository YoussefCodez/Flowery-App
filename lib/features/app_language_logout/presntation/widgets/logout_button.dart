import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/features/app_language_logout/presntation/cubit/logout_cubit.dart';
import 'package:flowery/features/app_language_logout/presntation/cubit/logout_state.dart';
import 'package:flowery/features/app_language_logout/presntation/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LogoutCubit>(),
      child: const _LogoutButtonContent(),
    );
  }
}

class _LogoutButtonContent extends StatefulWidget {
  const _LogoutButtonContent();

  @override
  State<_LogoutButtonContent> createState() => _LogoutButtonContentState();
}

class _LogoutButtonContentState extends State<_LogoutButtonContent> {
  @override
  void initState() {
    super.initState();
    context.read<LogoutCubit>().navigationStream.listen((nav) {
      if (!mounted) return;
      switch (nav) {
        case LogoutNavigation.goToLogin:
          context.pushNamedAndRemoveUntil(
            AppRoutes.login,
            predicate: (_) => false,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, BaseState<void>>(
      listener: (context, state) {
        // if (state.state == StateType.error) {
        //   final msg = state.exception is ServerFailure
        //       ? (state.exception as ServerFailure).errorMessage
        //       : AppLocalizations.of(context)!.error;
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(msg)),
        //   );
        // }
      },
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          return ListTile(
            onTap: () => LogoutDialog.show(
              context,
              onConfirm: () {
                Navigator.pop(context);
                context.read<LogoutCubit>().doAction(LogoutEvent.logout);
              },
            ),
            leading: const Icon(Icons.logout),
            title: Text(l10n.logout),
            trailing: const Icon(Icons.logout),
          );
        },
      ),
    );
  }
}
