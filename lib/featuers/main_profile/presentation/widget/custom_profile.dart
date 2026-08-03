import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileTile extends StatelessWidget {
  final Widget? leadingIcon;
  final String title;
  final Widget? trailingWidget;
  final VoidCallback? onTap;

  const CustomProfileTile({
    super.key,
    this.leadingIcon,
    required this.title,
    this.trailingWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            ...?leadingIcon != null
                ? [leadingIcon!, SizedBox(width: 12.w)]
                : null,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
      ),
    );
  }
}
