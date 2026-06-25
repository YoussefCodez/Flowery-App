import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entity/order_item_entity.dart';

class CustomProductCard2 extends StatelessWidget {
  final OrderItemEntity orderItem;
  final bool isActive;

  const CustomProductCard2({
    super.key,
    required this.orderItem,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 130.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColors.hintGrayColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: CachedNetworkImage(
              imageUrl: orderItem.product.imgCover,
              height: 130.h,
              width: 110.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    orderItem.product.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    l10n.egp_price(orderItem.price.toString()),
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    isActive
                        ? l10n.order_number(orderItem.id)
                        : l10n.delivered_on(
                            orderItem.product.updatedAt.day.toString(),
                            _monthName(orderItem.product.updatedAt.month),
                            orderItem.product.updatedAt.year.toString(),
                          ),
                    style: TextStyle(
                      color: AppColors.hintGrayColor,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        isActive ? l10n.track_order : l10n.reorder,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
