import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBill extends StatefulWidget {
  const CustomBill({super.key});

  @override
  State<CustomBill> createState() => _CustomBillState();
}

class _CustomBillState extends State<CustomBill> {
  late AppLocalizations localizations;
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: 343.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.sub_total,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "100 EGP",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.delivery_fee,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "10 EGP",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Divider(color: AppColors.grayColor, thickness: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.total,
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.blackColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "110 EGP",
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.blackColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),
          ElevatedButton(onPressed: () {}, child: Text(localizations.checkout)),
        ],
      ),
    );
  }
}
