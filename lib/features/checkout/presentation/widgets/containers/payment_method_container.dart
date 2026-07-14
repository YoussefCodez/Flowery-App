import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/checkout_state.dart';
import 'package:flowery/features/checkout/presentation/widgets/cards/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodContainer extends StatelessWidget {
  final AppLocalizations localizations;
  final TextTheme textTheme;
  const PaymentMethodContainer({super.key, required this.localizations, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Row(
          children: [
            SizedBox(width: 11.w),
            Text(
              localizations.payment_method,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        BlocSelector<CheckoutCubit, CheckoutState, bool>(
          selector: (state) => state.isCreditCard,
          builder: (context, isCreditCard) {
            return Column(
              children: [
                PaymentMethodCard(
                  isThisCreditCardContainer: false,
                  paymentMethodName: localizations.cash_on_delivery,
                  selectedMethod: isCreditCard,
                ),
                PaymentMethodCard(
                  isThisCreditCardContainer: true,
                  paymentMethodName: localizations.credit_card,
                  selectedMethod: isCreditCard,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
