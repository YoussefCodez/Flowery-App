import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  int _currentIndex = 0;

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (widget.images.isNotEmpty)
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: widget.images.length,
            itemBuilder: (context, index, realIndex) {
              return Image.network(widget.images[index], fit: BoxFit.cover);
            },
            options: CarouselOptions(
              height: 430.h,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) =>
                  setState(() => _currentIndex = index),
            ),
          )
        else
          SizedBox(
            height: 430.h,
            width: double.infinity,
            child: const Center(
              child: Icon(Icons.image_not_supported_outlined, size: 48),
            ),
          ),

        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.primary),
          ),
        ),

        if (widget.images.isNotEmpty)
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
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
