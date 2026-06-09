import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/l10n/translations/app_localizations.dart';

class HeaderCustomWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const HeaderCustomWidget({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 18.sp)),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            l10n.view_all,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
