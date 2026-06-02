import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/product_card_shimmer.dart';
import '../../../../core/widgets/shimer_box.dart';

class FlowerySkeleton extends StatelessWidget {
  const FlowerySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildDeliveryBar(),
               SizedBox(height: 16.h),
              _buildSectionHeaderSkeleton(),
              SizedBox(height: 16.h),
              _buildCategoriesSkeleton(),
              SizedBox(height: 16.h),
              _buildSectionHeaderSkeleton(),
              SizedBox(height: 16.h),
              _buildProductsGridSkeleton(),
              SizedBox(height: 16.h),
              _buildSectionHeaderSkeleton(),
              SizedBox(height: 16.h),
              _buildProductsGridSkeleton(),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color:AppColors.whiteColor),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.shimmerBackground,
                  borderRadius: BorderRadius.circular(10),
              ),
              padding:  EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  ShimmerBox(width: 16, height: 16, borderRadius: BorderRadius.circular(4.r)),
                   SizedBox(width: 8.w),
                   Expanded(child: ShimmerBox(width: double.infinity, height: 14.h)),
                ],
              ),
            ),
          ),
           SizedBox(width: 12.w),
           ShimmerBox(width: 90.w, height: 24.h),
        ],
      ),
    );
  }

  Widget _buildDeliveryBar() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.shimmerBackground ),
          bottom: BorderSide(color: AppColors.shimmerBackground),
        ),
      ),
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child:  Center(child: ShimmerBox(width: 200.w, height: 14.h)),
    );
  }

  Widget _buildSectionHeaderSkeleton() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           ShimmerBox(width: 90.w, height: 18.h),
          ShimmerBox(width: 60.w, height: 14.h, borderRadius: BorderRadius.circular(4.r)),
        ],
      ),
    );
  }

  Widget _buildCategoriesSkeleton() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 5,
        separatorBuilder: (_, __) =>  SizedBox(width: 12.w),
        itemBuilder: (_, __) => Column(
          children: [
            ShimmerBox.pink(width: 72.w, height: 72.h),
             SizedBox(height: 8.h),
             ShimmerBox(width: 50.w, height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGridSkeleton() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(child: ProductCardSkeleton()),
           SizedBox(width: 12.w),
          Expanded(child: ProductCardSkeleton()),
        ],
      ),
    );
  }

}

