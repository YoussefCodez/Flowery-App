import 'package:flutter/material.dart';

import '../../../../config/l10n/translations/app_localizations.dart';

AppBar customAppBar(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  return AppBar(
    titleSpacing: -10,

    title: Text(l10n.password),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
  );
}