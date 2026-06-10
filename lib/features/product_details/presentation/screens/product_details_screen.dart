import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/cart/presentation/view_model/cubit/cart_view_model.dart';
import 'package:flowery/features/cart/presentation/view_model/events/cart_events.dart';
import 'package:flowery/features/cart/presentation/view_model/states/cart_base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final bool isdescount;
  final double oldPrice;
  final double discount;
  final int sold;
  final int quantity;
  final List<String> images;
  final String description;
  final String id;

  const ProductDetailsScreen({
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
    required this.description,
    required this.id,
  });
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  late AppLocalizations localiztions;

  @override
  void didChangeDependencies() {
    localiztions = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CartViewModel>(
        create: (context) => getIt.get<CartViewModel>(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // Images
                Stack(
                  children: [
                    CarouselSlider.builder(
                      carouselController: _controller,
                      itemCount: widget.images.length,
                      itemBuilder: (context, index, realIndex) {
                        return CachedNetworkImage(
                          imageUrl: widget.images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 400.h,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) =>
                            setState(() => _currentIndex = index),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
        
                    Positioned(
                      bottom: 16.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          widget.images.length,
                          (index) => GestureDetector(
                            onTap: () => _controller.animateToPage(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentIndex == index ? 12 : 8,
                              height: _currentIndex == index ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Color(
                                        Theme.of(
                                          context,
                                        ).colorScheme.primary.value,
                                      )
                                    : Color(
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSecondary.value,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        
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
                            'EGP ${widget.price}',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: .w700, fontSize: 20.sp),
                          ),
                          Text(
                            widget.quantity == widget.sold
                                ? "Status: Out of stock"
                                : "Status: In stock",
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: .w500, fontSize: 16.sp),
                          ),
                        ],
                      ),
                      Text(
                        'All prices include tax',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: .w400,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        '${widget.quantity} ${widget.title}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: .w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Description:',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: .w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
        
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: .w400,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 60.h),
                      Text(
                        'Bouquet include:',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: .w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${widget.title}:${widget.quantity}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: .w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () => context.read<CartViewModel>()
                      ..doEvent(
                        AddToCartEvent(),
                        cartItemId: widget.id,
                        quantity: 1,
                      ),
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
                                localiztions.add_to_cart,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
