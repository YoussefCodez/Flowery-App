import 'package:flowery/config/general_cubit/general_state.dart';
import 'package:flowery/config/general_cubit/local_cubit.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/app_language_logout/presntation/widgets/change_language_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleThemeCubit, LocaleThemeState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final primaryColor = Theme.of(context).colorScheme.primary;
        final currentLang =
            state.locale.languageCode == 'ar' ? l10n.arabic : l10n.english;
        return ListTile(
          onTap: () => ChangeLanguageBottomSheet.show(context),
          leading: const Icon(Icons.translate),
          title: Text(l10n.language),
          trailing: Text(
            currentLang,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
