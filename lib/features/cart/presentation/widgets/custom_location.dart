import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class CustomLocation extends StatelessWidget {
  const CustomLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined),
        Text(
          " Deliver to ",
          style: TextStyle(fontSize: 20.sp, color: AppColors.grayColor),
        ),
        Text(
          "2XVP+XC - Sheikh Zayed.....",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        Icon(
          Icons.keyboard_arrow_down_sharp,
          size: 30.sp,
          fontWeight: FontWeight.w100,
          weight: 10,
        ),
      ],
    );
  }
}
