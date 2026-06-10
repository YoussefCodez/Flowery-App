import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/const/app_strings.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_manager.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductCard extends StatefulWidget {
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
    required this.description,
  });

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  late AppLocalizations localizations;
  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        AppRoutes.productDetails,
        arguments: <String, dynamic>{
          AppStrings.title: widget.title,
          AppStrings.image: widget.image,
          AppStrings.price: widget.price,
          AppStrings.discount: widget.discount,
          AppStrings.sold: widget.sold,
          AppStrings.quantity: widget.quantity,
          AppStrings.images: widget.images,
          AppStrings.id: widget.id,
          AppStrings.description: widget.description,
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: REdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: widget.image,
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
                  widget.title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 12.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "${localizations.egp} ${widget.price}",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 7.w),

                    Flexible(
                      child: Text(
                        "${widget.oldPrice}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                    ),
                    SizedBox(width: 7.w),

                    Flexible(
                      child: Text(
                        "${widget.discount}%",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
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
              onPressed: () {
                context.read<CartManager>().addToCart(widget.id, 1);
                context.read<CartManager>().getCartUseCase();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<CartManager, CartState>(
                    builder: (context, state) {
                      if (state.isLoading == true) {
                        return Center(
                          child: SizedBox(
                            height: 15.h,
                            width: 15.w,
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        );
                      } else {
                        return Row(
                          children: [
                            Icon(Icons.shopping_cart_outlined, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              AppStrings.addToCart,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
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
    );
  }
}
