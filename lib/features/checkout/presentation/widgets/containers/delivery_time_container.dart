import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryTimeContainer extends StatelessWidget {
  final AppLocalizations localizations;
  final TextTheme textTheme;
  final int deliveryDays;
  const DeliveryTimeContainer({
    super.key,
    required this.localizations,
    required this.textTheme,
    required this.deliveryDays,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryDate = DateTime.now().add(Duration(days: deliveryDays));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 3.w),
              Text(
                localizations.delivery_time,
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.timer_outlined, size: 25.sp),
              Text(localizations.instant, style: textTheme.labelLarge),
              Text(
                " ${localizations.arrive_by} $deliveryDate",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.greenColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
