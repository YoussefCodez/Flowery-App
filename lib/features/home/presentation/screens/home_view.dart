import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/widgets/custom_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/const/app_svgs.dart';
import '../../../../core/theme/app_colors.dart';
import '../widget/categories_custom_widget.dart';
import '../widget/header_custom_widget.dart';
import '../widget/occasion_custom_widget.dart';
import '../widget/product_custom_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),

              SafeArea(
                child: Row(
                  children: [
                    SvgPicture.asset(AppSvgs.logo, width: 30.w, height: 40.h),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: InkWell(
                        onTap: () => context.pushNamed(AppRoutes.search),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.hintGrayColor,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: AppColors.hintGrayColor,
                              ),

                              SizedBox(width: 8.w),

                              Text(
                                l10n.search,
                                style: TextStyle(
                                  color: AppColors.hintGrayColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),

              LocationCustomWidget(),
              SizedBox(height: 15.h),

              HeaderCustomWidget(
                title: l10n.categories,
                onPressed: () => context.pushNamed(AppRoutes.categories),
              ),
              SizedBox(height: 10.h),

              CategoriesCustomWidget(),
              SizedBox(height: 15.h),

              HeaderCustomWidget(
                title: l10n.best_seller,
                onPressed: () => context.pushNamed(AppRoutes.bestSeller),
              ),
              SizedBox(height: 10.h),
              BestSellerCustomWidget(),
              SizedBox(height: 15.h),

              HeaderCustomWidget(
                title: l10n.occasion,
                onPressed: () => context.pushNamed(AppRoutes.occasions),
              ),
              SizedBox(height: 10.h),
              OccasionCustomWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
