import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../view_model/home_cubit.dart';
import '../view_model/state_event.dart';

class CategoriesCustomWidget extends StatelessWidget {
  const CategoriesCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      buildWhen: (previous, current) =>
      previous.categoryState != current.categoryState,
      builder: (context, state) {
        return state.categoryState.when(
          initial: () => const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
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
      },
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
    const pinkColor = AppColors.primaryColor;
    const pinkBg = Color(0xFFFCE4EC);

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
                color: pinkBg,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Padding(
                  padding:  EdgeInsets.all(15.h),
                  child: Image.network(
                    image!,
                    width: 64.w,
                    height: 64.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(
                      Icons.category_outlined,
                      color: pinkColor,
                      size: 28,
                    ),
                  ),
                ),
              )
                  : const Icon(
                Icons.category_outlined,
                color: pinkColor,
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