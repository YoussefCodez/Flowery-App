import 'package:flowery/core/widgets/shimer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(
          width: double.infinity,
          height: 160,
          borderRadius: BorderRadius.circular(14.r),
        ),
         SizedBox(height: 8.h),
         ShimmerBox(width: 120.w, height: 14.h),
         SizedBox(height: 6.h),
         ShimmerBox(width: 80.w, height: 12.h),
      ],
    );
  }
}