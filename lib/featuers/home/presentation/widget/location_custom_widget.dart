import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class LocationCustomWidget extends StatelessWidget {
  const LocationCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(Icons.location_on_outlined),
        SizedBox(width: 8.w),
        Text("Deliver to 2XVP+XC - Sheikh Zayed "),
        SizedBox(width: 6.w),
        Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.primaryColor,),

      ],
    );
  }
}
