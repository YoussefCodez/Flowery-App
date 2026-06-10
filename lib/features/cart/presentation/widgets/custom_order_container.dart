import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flowery/features/cart/presentation/cart_manager/cart_manager.dart';
import 'package:flowery/features/cart/presentation/cart_manager/cart_state.dart';
import 'package:flowery/features/cart/presentation/view_model/cubit/cart_view_model.dart';
import 'package:flowery/features/cart/presentation/view_model/events/cart_events.dart';
import 'package:flowery/features/cart/presentation/view_model/states/cart_base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrderContainer extends StatefulWidget {
  final CartItemEntity cartItem;
  const CustomOrderContainer({super.key, required this.cartItem});

  @override
  State<CustomOrderContainer> createState() => _CustomOrderContainerState();
}

class _CustomOrderContainerState extends State<CustomOrderContainer> {
  late TextTheme textTheme;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    localizations = AppLocalizations.of(context)!;
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
      child: BlocBuilder<CartManager, CartState>(
        builder: (context, state) {
          if (state.isDeletingCartItem == true &&
              state.itemId == widget.cartItem.product?.productId) {
            return Center(
              child: SizedBox(
                width: 50.w,
                height: 50.h,
                child: CircularProgressIndicator(strokeWidth: 2.w),
              ),
            );
          } else {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: CachedNetworkImage(
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.cover,

                    imageUrl: widget.cartItem.product?.imgCover ?? "",
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

                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),

                          Text(
                            widget.cartItem.product?.title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelMedium?.copyWith(
                              color: AppColors.blackColor,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            widget.cartItem.product?.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelMedium?.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.grayColor,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25.h),

                      Text(
                        "${widget.cartItem.product?.price.toString()} ${localizations.egp}",
                        style: textTheme.labelMedium?.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CartManager>().deleteItem(
                          widget.cartItem.product?.productId ?? "",
                        );
                      },
                      icon: Icon(Icons.delete_forever_rounded, size: 30),
                      color: AppColors.redColor,
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CartManager>().updateQuantity(
 
                                  widget.cartItem.product?.productId ?? "",
widget.cartItem.quantity! - 1,
                            );
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          color: AppColors.blackColor,
                        ),
                        BlocBuilder<CartManager, CartState>(
                          builder: (context,state) {
                            if (state.isUpdatingCartItem == true &&
                                state.itemId ==
                                    widget.cartItem.product?.productId) {
                              return Center(
                                child: SizedBox(
                                  width: 10.w,
                                  height: 10.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.w,
                                  ),
                                ),
                              );
                            } else {
                              return Text(
                                widget.cartItem.quantity.toString(),
                                style: textTheme.labelMedium?.copyWith(
                                  color: AppColors.blackColor,
                                  decoration: TextDecoration.none,
                                ),
                              );
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CartManager>().updateQuantity(
                              widget.cartItem.product?.productId ?? "",
                              widget.cartItem.quantity! + 1,
                            );
                          },
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
            );
          }
        },
      ),
    );
  }
}
