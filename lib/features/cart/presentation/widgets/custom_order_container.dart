import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrderContainer extends StatefulWidget {
  const CustomOrderContainer({super.key});

  @override
  State<CustomOrderContainer> createState() => _CustomOrderContainerState();
}

class _CustomOrderContainerState extends State<CustomOrderContainer> {
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      padding: EdgeInsets.only(left: 10.w, bottom: 10.h, top: 10.h),
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(width: 0.5.w, color: AppColors.grayColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: CachedNetworkImage(
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,

              imageUrl:
                  "https://assets.bucketlistly.blog/sites/5adf778b6eabcc00190b75b1/content_entry5adf77af6eabcc00190b75b6/6075185986d092000b192d0a/files/best-free-travel-images-main-image-hd-op.webp",
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(strokeWidth: 2.w),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          SizedBox(width: 5.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  Text(
                    "Red roses",
                    style: textTheme.labelMedium?.copyWith(
                      color: AppColors.blackColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    "15 Pink Rose Bouquet",
                    style: textTheme.labelMedium?.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.grayColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              Text(
                "EGP 600",
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_forever_rounded, size: 30),
                color: AppColors.redColor,
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                      size: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    color: AppColors.blackColor,
                  ),
                  Text(
                    "1",
                    style: textTheme.labelMedium?.copyWith(
                      color: AppColors.blackColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      size: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
