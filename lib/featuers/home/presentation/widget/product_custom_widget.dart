import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../config/l10n/translations/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/product_card_shimmer.dart';
import '../../domain/home_enitiy/best_seller_entity.dart';

class BestSellerCustomWidget extends StatelessWidget {
  final BaseState<List<BestSellerEntity>> bestSellerState;

  const BestSellerCustomWidget({super.key, required this.bestSellerState});

  @override
  Widget build(BuildContext context) {
    return bestSellerState.when(
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
          style: const TextStyle(color: AppColors.redColor),
        ),
      ),
      success: (products) => SizedBox(
        height: 220.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            final product = products[index];
            return _BestSellerCard(product: product);
          },
        ),
      ),
    );
  }
}

class _BestSellerCard extends StatelessWidget {
  final BestSellerEntity product;

  const _BestSellerCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        // context.pushNamed(AppRoutes.productDetails, arguments: product.id);
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
                product.imgCover ?? '',
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
              product.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${product.price ?? 0} ${l10n.egp}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
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
      color: AppColors.whiteColor,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}