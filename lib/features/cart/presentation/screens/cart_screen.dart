import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_manager.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_state.dart';
import 'package:flowery/core/widgets/custom_bill.dart';
import 'package:flowery/core/widgets/custom_location.dart';
import 'package:flowery/features/cart/presentation/widgets/custom_order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late AppLocalizations localizations;

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
              SizedBox(width: 16.w),
              Text(localizations.cart),
              BlocBuilder<CartManager, CartState>(
                builder: (context, state) {
                  // Loading
                  if (state.isLoading == true) {
                    return Text(
                      " (0 ${localizations.items})",
                      style: TextStyle(color: AppColors.grayColor),
                    );
                  } else {
                    // Loaded Successfully
                    return Text(
                      " (${state.cart?.numberOfCartItems} ${localizations.items})",
                      style: TextStyle(color: AppColors.grayColor),
                    );
                  }
                },
              ),
            ],
          ),
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size(200.w, 40.h),
            child: LocationCustomWidget(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartManager, CartState>(
                builder: (context, state) {
                  if (state.isLoading == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.cart?.numberOfCartItems == 0) {
                    return Center(
                      child: Text(localizations.your_cart_is_empty),
                    );
                  } else {
                    return Scrollbar(
                      thickness: 6.w,
                      child: ListView.builder(
                        itemCount: state.cart?.numberOfCartItems,
                        itemBuilder: (context, index) {
                          return CustomOrderContainer(
                            cartItem: state.cart!.cartItems![index],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10.h),

            BlocBuilder<CartManager, CartState>(
              builder: (context, state) {
                if (state.isLoading == false &&
                    state.cart!.numberOfCartItems! > 0) {
                  return CustomBill(
                    subtotal: state.cart?.totalPriceBeforeDiscount,
                    discount: state.cart?.discount,
                    subtotalAfterDiscount: state.cart?.totalPriceAfterDiscount,
                    deliveryFee: 50,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
