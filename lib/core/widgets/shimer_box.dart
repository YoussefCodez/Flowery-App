import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Color baseColor;
  final Color highlightColor;

   ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.baseColor =AppColors.shimmerBase ,
    this.highlightColor = AppColors.shimmerHighlight,
     BorderRadius? borderRadius,
  }):borderRadius =  BorderRadius.all(Radius.circular(8.r));

   ShimmerBox.pink({
    super.key,
    required this.width,
    required this.height,
    this.baseColor = AppColors.shimmerPinkBase  ,
    this.highlightColor = AppColors.shimmerPinkHighlight ,
     BorderRadius? borderRadius,

   }):borderRadius =   BorderRadius.all(Radius.circular(14.r));

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _animation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}