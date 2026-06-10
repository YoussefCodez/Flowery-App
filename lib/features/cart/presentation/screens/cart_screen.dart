import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/cart/presentation/view_model/cubit/cart_view_model.dart';
import 'package:flowery/features/cart/presentation/view_model/events/cart_events.dart';
import 'package:flowery/features/cart/presentation/view_model/states/cart_base_state.dart';
import 'package:flowery/features/cart/presentation/widgets/custom_bill.dart';
import 'package:flowery/features/cart/presentation/widgets/custom_location.dart';
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
      child: BlocProvider<CartViewModel>(
        create: (context) =>
            getIt.get<CartViewModel>()..doEvent(GetUserCartProductsEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(localizations.cart),
                BlocBuilder<CartViewModel, CartBaseState>(
                  builder: (context, state) {
                    // Loading
                    if (state.isLoadingCart == true) {
                      return Text(
                        " (0 ${localizations.items})",
                        style: TextStyle(color: AppColors.grayColor),
                      );
                    } else {
                      // Loaded Successfully
                      return Text(
                        " (${state.cart.numberOfCartItems} ${localizations.items})",
                        style: TextStyle(color: AppColors.grayColor),
                      );
                    }
                  },
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
                child: BlocBuilder<CartViewModel, CartBaseState>(
                  builder: (context, state) {
                    if (state.isLoadingCart == true) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.cart.numberOfCartItems == 0) {
                      return Center(
                        child: Text(localizations.your_cart_is_empty),
                      );
                    } else {
                      return Scrollbar(
                        thickness: 6.w,
                        child: ListView.builder(
                          itemCount: state.cart.numberOfCartItems,
                          itemBuilder: (context, index) {
                            return CustomOrderContainer(
                              cartItem: state.cart.cartItems![index],
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 10.h),

              BlocBuilder<CartViewModel, CartBaseState>(
                builder: (context, state) {
                  if (state.isLoadingCart == false &&
                      state.cart.numberOfCartItems! > 0) {
                    return CustomBill(
                      subtotal: state.cart.totalPriceBeforeDiscount,
                      discount: state.cart.discount,
                      subtotalAfterDiscount: state.cart.totalPriceAfterDiscount,
                      deliveryFee: state.deliveryFee,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
