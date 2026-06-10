import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/const/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/search_entity/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRoutes.productDetails,
        arguments: <String, dynamic>{
          AppStrings.title: product.title,
          AppStrings.price: product.price,
          AppStrings.discount: product.discount,
          AppStrings.sold: product.sold,
          AppStrings.quantity: product.quantity,
          AppStrings.images: product.images,
          AppStrings.id: product.id,
          AppStrings.description: product.description,
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              product.imgCover ?? '',
              width: double.infinity,
              height: 150.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(height: 150.h, color: const Color(0xFFF5F5F5)),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            product.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          ),
          Text(
            '${product.price ?? 0} EGP',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
