import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBubble extends StatefulWidget {
  const FilterBubble({super.key});

  @override
  State<FilterBubble> createState() => _FilterBubbleState();
}

class _FilterBubbleState extends State<FilterBubble> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.tune, color: AppColors.whiteColor),
          SizedBox(width: 8.w),
          Text(
            localizations.filter,
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}