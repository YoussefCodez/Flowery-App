import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/products_details/presentation/product_images_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final bool isdescount;
  final double oldPrice;
  final double discount;
  final int sold;
  final int quantity;
  final List<String> images;

  const ProductsDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.isdescount,
    required this.oldPrice,
    required this.discount,
    required this.sold,
    required this.quantity,
    required this.images,
  });
  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  late AppLocalizations? appLocalizations;
  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProductImagesSlider(images: widget.images),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${appLocalizations!.egp} ${widget.price}',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: .w700,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        appLocalizations!.status_in_stock,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: .w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    appLocalizations!.all_prices_include_tax,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: .w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    '${widget.quantity} ${widget.title}${appLocalizations!.bouquet}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: .w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    appLocalizations!.description,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: .w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Text(
                    appLocalizations!.bouquet_include,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: .w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${widget.title}:${widget.quantity}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: .w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                ),
                onPressed: () {
                  // Handle button press
                },
                child: Text(appLocalizations!.add_to_cart),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
