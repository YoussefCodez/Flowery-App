import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/checkout/presentation/widgets/custom_address_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late AppLocalizations localizaions;
  late TextTheme textTheme;

  @override
  void didChangeDependencies() {
    localizaions = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        titleSpacing: 0.0,
        title: Text(localizaions.checkout),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Time
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 3.w),
                    Text(
                      localizaions.delivery_time,
                      style: textTheme.bodyLarge?.copyWith(fontSize: 18.sp),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 25.sp),
                    Text(localizaions.instant, style: textTheme.labelLarge),
                    Text(
                      " Arrive by 03 Sep 2024, 11:00 AM",
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.greenColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          Divider(color: AppColors.dividerColor, height: 24.h, thickness: 24.h),
          // Delivery address
          Expanded(
            child: Column(
              children: [
                Text(
                  localizaions.delivery_address,
                  style: textTheme.bodyLarge?.copyWith(fontSize: 18.sp),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomAddressContainer(
                        addressTitle: "Home",
                        addressDetails: "this is my home",
                      );
                    },
                    itemCount: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
