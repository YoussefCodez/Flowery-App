import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/core/const/app_svgs.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainProfileView extends StatelessWidget {
  const MainProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none_rounded, size: 25.w,),
                ),
                SvgPicture.asset(AppSvgs.logo, height: 30.h, width: 70.w,),
              ],
            ),
            CircleAvatar(
              radius: 50.r,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: "imageUrl" ?? '',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.hintGrayColor,
                    child:  Center(
                      child: Icon(
                        Icons.person,
                        size: 40.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h,),
            Text("Nour",style: TextStyle(fontWeight: FontWeight.w500,fontSize:18.sp ),),
            Text("Nour@gmail.com",style: TextStyle(fontWeight: FontWeight.w500,fontSize:18.sp ,color: AppColors.grayColor),),
          ],
        ),
      ),
    );
  }
}
