import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_model/search_cubit.dart';
import '../view_model/search_event.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.hintGrayColor),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.hintGrayColor, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  context.read<SearchViewModel>().doEvent(ClearSearchEvent());
                } else {
                  context.read<SearchViewModel>().doEvent(
                    SearchProductsEvent(value.trim()),
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.hintGrayColor,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _controller.clear(); // ✅ بيمسح الـ text
              context.read<SearchViewModel>().doEvent(ClearSearchEvent());
            },
            child: Container(
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.hintGrayColor),
              ),
              child: Icon(Icons.close, size: 14.sp, color: AppColors.hintGrayColor),
            ),
          ),
        ],
      ),
    );
  }
}