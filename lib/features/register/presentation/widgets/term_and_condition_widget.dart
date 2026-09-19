import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Text.rich(
      TextSpan(
        text: localizations.creatingAccountAgreement.replaceAll(
          localizations.termsAndConditions,
          '',
        ),
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.grayColor,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: localizations.termsAndConditions,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}