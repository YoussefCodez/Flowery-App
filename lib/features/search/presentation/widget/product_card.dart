import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/search_entity/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.productDetails,
          arguments: <String, dynamic>{
            "title": product.title,
            "image": product.imgCover,
            "price": product.priceAfterDiscount,
            "hasDiscount": product.discount! > 0 ? true : false,
            "oldPrice": product.price,
            "discount": product.discount,
            "sold": product.sold,
            "quantity": product.quantity,
            "images": product.images,
            "description": product.description,
          },
        );
      },
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
            '${product.priceAfterDiscount ?? 0} EGP',
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
