import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/const/edit_profile_values.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderCard extends StatelessWidget {
  final AppLocalizations localizations;
  final String gender;
  const GenderCard({
    super.key,
    required this.localizations,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          localizations.gender,
          style: TextStyle(
            color: AppColors.grayColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 50.w),
        Row(
          children: [
            RadioMenuButton(
              value: EditProfileValues.male,
              groupValue: gender,
              onChanged: (_) {},
              child: Text(localizations.male),
            ),
            RadioMenuButton(
              value: EditProfileValues.female,
              groupValue: gender,
              onChanged: (_) {},
              child: Text(localizations.female),
            ),
          ],
        ),
      ],
    );
  }
}
