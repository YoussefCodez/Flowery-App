import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  const SearchField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.search);
      },
      child: TextField(
        enabled: false,
        cursorColor: Theme.of(context).colorScheme.onSecondary,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: .w500,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: .w500,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}
