import 'package:flowery/core/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridView extends StatelessWidget {
  final int productsLength;
  final List<dynamic> products;
  const CustomGridView({
    super.key,
    required this.productsLength,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: REdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return CustomProductCard(
            title: products[index].title ?? "",
            image: products[index].imgCover ?? "",
            price: products[index].priceAfterDiscount?.toDouble() ?? 0,
            discount: products[index].discount?.toDouble() ?? 0,
            hasDiscount: products[index].discount != null && products[index].discount! > 0,
            oldPrice: products[index].price?.toDouble() ?? 0,
            sold: products[index].discount?.toInt() ?? 0,
            quantity: products[index].quantity ?? 0,
            images: products[index].images ?? [],
          );
        },
        itemCount: productsLength,
      ),
    );
  }
}