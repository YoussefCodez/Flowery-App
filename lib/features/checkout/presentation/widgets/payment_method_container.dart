import 'package:flowery/features/checkout/presentation/view_model/cubit/checkout_view_model.dart';
import 'package:flowery/features/checkout/presentation/view_model/events/checkout_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodContainer extends StatelessWidget {
  final String paymentMethodName;
  final bool selectedMethod;
  final bool isThisCreditCardContainer;

  const PaymentMethodContainer({
    super.key,
    required this.isThisCreditCardContainer,
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
                  value: isThisCreditCardContainer,
                  groupValue: selectedMethod,
                  onChanged: (_) {
                    context.read<CheckoutViewModel>().doEvent(
                      ChangePaymentMethodEvent(
                        isThisCreditCardContainer == true ? true : false,
                      ),
                    );
                  },
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
