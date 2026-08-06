import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/product_card_shimmer.dart';
import '../../domain/home_enitiy/occasion_enitity.dart';

class OccasionCustomWidget extends StatelessWidget {
  final BaseState<List<OccasionEntity>> occasionState;

  const OccasionCustomWidget({super.key, required this.occasionState});

  @override
  Widget build(BuildContext context) {
    return occasionState.when(
      initial: () => const SizedBox(),
      loading: () => SizedBox(
        height: 220.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: 3,
          separatorBuilder: (_, __) => SizedBox(width: 16.w),
          itemBuilder: (_, __) => SizedBox(
            width: 160.w,
            child: ProductCardSkeleton(),
          ),
        ),
      ),
      error: (exception) => Center(
        child: Text(
          exception.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      ),
      success: (occasions) => SizedBox(
        height: 220.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: occasions.length,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            final occasion = occasions[index];
            return _OccasionCard(occasion: occasion);
          },
        ),
      ),
    );
  }
}

class _OccasionCard extends StatelessWidget {
  final OccasionEntity occasion;

  const _OccasionCard({required this.occasion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushNamed(AppRoutes.occasionProducts, arguments: occasion.id);
      },
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                occasion.image ?? '',
                width: 160.w,
                height: 160.h,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _Placeholder();
                },
                errorBuilder: (_, __, ___) => _Placeholder(),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              occasion.name ?? '',
              style: TextStyle(
                fontSize: 14.sp,
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

class _Placeholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 160.h,
      color: const Color(0xFFF5F5F5),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}