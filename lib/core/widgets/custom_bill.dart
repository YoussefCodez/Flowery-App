import 'package:flowery/config/general_cubit/address_view_model/cubit/address_status_cubit.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/save_address/presentation/screens/saved_addresses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBill extends StatefulWidget {
  final int? subtotal;
  final int? discount;
  final int? subtotalAfterDiscount;
  final bool? isItPlaceOrder;
  int get total => (subtotalAfterDiscount ?? 0);
  int get discountMoney => (subtotalAfterDiscount ?? 0) - (subtotal ?? 0);
  const CustomBill({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.subtotalAfterDiscount,
    this.isItPlaceOrder,
  });

  @override
  State<CustomBill> createState() => _CustomBillState();
}

class _CustomBillState extends State<CustomBill> {
  late AppLocalizations localizations;
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: 343.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.sub_total,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${widget.subtotal.toString()} ${localizations.egp}",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${localizations.discount} (${widget.discount}%)",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${widget.discountMoney.toString()} ${localizations.egp}",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.sub_total_after_discount,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${widget.subtotalAfterDiscount.toString()} ${localizations.egp}",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.grayColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          Divider(color: AppColors.grayColor, thickness: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.total,
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.blackColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.total} ${localizations.egp}",
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.blackColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          widget.isItPlaceOrder == null
              ? ElevatedButton(
                  onPressed: () {
                    final hasAddress = context
                        .read<AddressStatusCubit>()
                        .state
                        .hasAddress;

                    if (!hasAddress) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please add a delivery address first'),
                        ),
                      );
                    } else {
                      context.pushNamed(
                        AppRoutes.checkout,
                        arguments: TransferBill(
                          subtotal: widget.subtotal ?? 0,
                          discount: widget.discount ?? 0,
                          subtotalAfterDiscount:
                              widget.subtotalAfterDiscount ?? 0,
                        ),
                      );
                    }
                  },
                  child: Text(localizations.checkout),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class TransferBill {
  final int subtotal;
  final int discount;
  final int subtotalAfterDiscount;

  TransferBill({
    required this.subtotal,
    required this.discount,
    required this.subtotalAfterDiscount,
  });
}
