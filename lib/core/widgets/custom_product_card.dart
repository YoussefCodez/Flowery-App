import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/cart/presentation/view_model/cubit/cart_view_model.dart';
import 'package:flowery/features/cart/presentation/view_model/events/cart_events.dart';
import 'package:flowery/features/cart/presentation/view_model/states/cart_base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductCard extends StatelessWidget {
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
  final String id;
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
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartViewModel>(
      create: (context) => getIt.get<CartViewModel>(),
      child: Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              context.pushNamed(
                AppRoutes.productDetails,
                arguments: <String, dynamic>{
                  "title": title,
                  "image": image,
                  "price": price,
                  "hasDiscount": hasDiscount,
                  "oldPrice": oldPrice,
                  "discount": discount,
                  "sold": sold,
                  "quantity": quantity,
                  "images": images,
                  "description": description,
                  "id": id,
                },
              );
            },
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
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                          ),
                          Text(
                            "$oldPrice",
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                  decorationThickness: 1.w,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                  fontSize: 12.sp,
                                ),
                          ),
                          Expanded(
                            child: Text(
                              "$discount%",
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    fontWeight: .w400,
                                    color: AppColors.greenColor,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ElevatedButton(
                    onPressed: () => context.read<CartViewModel>()
                      ..doEvent(AddToCartEvent(), cartItemId: id, quantity: 1),
                    child: BlocBuilder<CartViewModel, CartBaseState>(
                      builder: (context, state) {
                        if (state.isAddingToCart == true) {
                          return SizedBox(
                            height: 15.h,
                            width: 15.w,
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 16.sp),
                              SizedBox(width: 4.w),
                              Text(
                                AppLocalizations.of(context)!.add_to_cart,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
