import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/const/app_strings.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/cart/presentation/view_model/cubit/cart_view_model.dart';
import 'package:flowery/features/cart/presentation/view_model/events/cart_events.dart';
import 'package:flowery/features/cart/presentation/view_model/states/cart_base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductCard extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final double price;
  final bool hasDiscount;
  final double oldPrice;
  final double discount;
  final int sold;
  final int quantity;
  final List<String> images;
  final String description;
  const CustomProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    this.hasDiscount = false,
    this.oldPrice = 0,
    this.discount = 0,
    required this.sold,
    required this.quantity,
    required this.images,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartViewModel>(
      create: (context) => getIt.get<CartViewModel>(),
      child: InkWell(
        onTap: () => context.pushNamed(
          AppRoutes.productDetails,
          arguments: <String, dynamic>{
            AppStrings.title: title,
            AppStrings.image: image,
            AppStrings.price: price,
            AppStrings.discount: discount,
            AppStrings.sold: sold,
            AppStrings.quantity: quantity,
            AppStrings.images: images,
          },
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: REdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: 130.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(fontSize: 12.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 7.sp,
                    children: [
                      Text(
                        "EGP $price",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: .w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        "$oldPrice",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Theme.of(
                            context,
                          ).colorScheme.onSecondary,
                          decorationThickness: 1.w,
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        "$discount%",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: .w400,
                          color: AppColors.greenColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ElevatedButton(
                onPressed: () =>
                    context.read<CartViewModel>()
                      ..doEvent(AddToCartEvent(), cartItemId: id, quantity: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 16.sp),
                    SizedBox(width: 4.w),
                    BlocBuilder<CartViewModel, CartBaseState>(
                      builder: (context, state) {
                        if (state.isAddingToCart == true) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Text(
                            AppStrings.addToCart,
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
