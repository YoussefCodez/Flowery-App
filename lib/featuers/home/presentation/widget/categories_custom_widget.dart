import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shimer_box.dart';
import '../../domain/home_enitiy/category_entity.dart';

class CategoriesCustomWidget extends StatelessWidget {
  final BaseState<List<CategoryEntity>> categoryState;

  const CategoriesCustomWidget({super.key, required this.categoryState});

  @override
  Widget build(BuildContext context) {
    return categoryState.when(
      initial: () => const SizedBox(),
      loading: () => SizedBox(
        height: 100.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: 5,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (_, __) => Column(
            children: [
              ShimmerBox.pink(width: 64.w, height: 64.h),
              SizedBox(height: 8.h),
              ShimmerBox(width: 50.w, height: 12.h),
            ],
          ),
        ),
      ),
      error: (exception) => Center(
        child: Text(
          exception.toString(),
          style: const TextStyle(color:  AppColors.primaryColor),
        ),
      ),
      success: (categories) => SizedBox(
        height: 100.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            final category = categories[index];
            return _CategoryCard(
              image: category.image,
              label: category.name ?? '',
              categoryId: category.id,
            );
          },
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String? image;
  final String label;
  final String? categoryId;

  const _CategoryCard({
    required this.image,
    required this.label,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushNamed(AppRoutes.categoryProducts, arguments: categoryId);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: AppColors.categoryIconBackground,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Padding(
                  padding:  EdgeInsets.all(15.h),
                  child: CachedNetworkImage(
                    imageUrl: image!,
                    width: 64.w,
                    height: 64.h,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) =>
                    const Icon(
                      Icons.category_outlined,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                  ),
                ),
              )
                  : const Icon(
                Icons.category_outlined,
                color: AppColors.primaryColor,
                size: 28,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}