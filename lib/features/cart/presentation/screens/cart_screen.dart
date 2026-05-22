import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/cart/presentation/widgets/custom_bill.dart';
import 'package:flowery/features/cart/presentation/widgets/custom_location.dart';
import 'package:flowery/features/cart/presentation/widgets/custom_order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late AppLocalizations localizations;
  final int numberOfItems = 0;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375.w, 812.h),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(localizations.cart),
              Text(
                " ($numberOfItems ${localizations.items})",
                style: TextStyle(color: AppColors.grayColor),
              ),
            ],
          ),
          titleSpacing: 0.0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          bottom: PreferredSize(
            preferredSize: Size(343.w, 40.h),
            child: CustomLocation(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 6.w,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (meow, index) {
                    return CustomOrderContainer();
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),
            CustomBill(),
          ],
        ),
      ),
    );
  }
}
