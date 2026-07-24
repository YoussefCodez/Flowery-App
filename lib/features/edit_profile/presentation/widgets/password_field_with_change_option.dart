import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordFieldWithChangeOption extends StatelessWidget {
  final TextEditingController passwordController;
  final AppLocalizations localizations;
  const PasswordFieldWithChangeOption({
    super.key,
    required this.passwordController,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        MainTextField(
          controller: passwordController,
          hintText: localizations.password,
          labelText: localizations.password,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
            },
            child: Text(
              localizations.change,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
