import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodContainer extends StatelessWidget {
  final String paymentMethodName;
  final bool selectedMethod;

  const PaymentMethodContainer({
    super.key,
    required this.paymentMethodName,
    required this.selectedMethod,
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    paymentMethodName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                RadioMenuButton(
                  value: true,
                  groupValue: selectedMethod,
                  onChanged: (_) {},
                  child: Text(""),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
