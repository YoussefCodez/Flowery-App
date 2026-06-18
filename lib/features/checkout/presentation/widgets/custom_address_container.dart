import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddressContainer extends StatelessWidget {
  final String addressTitle;
  final String addressDetails;
  final bool selectedAddress;

  const CustomAddressContainer({
    super.key,
    required this.addressTitle,
    required this.addressDetails,
    required this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            height: 75.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioMenuButton(
                      value: true,
                      groupValue: selectedAddress,
                      onChanged: (_) {},
                      child: Text(
                        addressTitle,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SizedBox(width: 20.w),
                        Text(addressDetails),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
