import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_manager.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_state.dart';
import 'package:flowery/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flowery/core/widgets/custom_bill.dart';
import 'package:flowery/core/widgets/custom_location.dart';
import 'package:flowery/features/cart/presentation/widgets/cart_item_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 16.w),
            Text(localizations.cart),
            BlocConsumer<CartManager, CartState>(
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
                    " (${state.cart?.numberOfCartItems ?? 0} ${localizations.items})",
                    style: TextStyle(color: AppColors.grayColor),
                  );
                }
              },
              listener: (context, state) {
                if (state.errorMessage != null && state.errorMessage != "") {

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? "")));
                }
              },
            ),
          ],
        ),
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size(200.w, 40.h),
          child: CustomLocation(),
        ),
      ),
      body: Column(
        children: [
          // Cart Items
          Expanded(
            child: BlocBuilder<CartManager, CartState>(
              builder: (context, state) {
                if (state.isLoadingCart == true) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.cart?.numberOfCartItems == null ||
                    state.cart?.numberOfCartItems == 0) {
                  return Center(child: Text(localizations.your_cart_is_empty));
                }
                return Scrollbar(
                  thickness: 6.w,
                  child: ListView.builder(
                    itemCount: state.cart?.numberOfCartItems,
                    itemBuilder: (context, index) {
                      return CartItemCard(
                        cartItem:
                            state.cart?.cartItems?[index] ??
                            CartItemEntity(product: null, quantity: 1),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 10.h),

          // Bill
          BlocBuilder<CartManager, CartState>(
            builder: (context, state) {
              final numberOfItems = state.cart?.numberOfCartItems ?? 0;
              if (state.isLoadingCart == false && numberOfItems > 0) {
                return CustomBill(
                  subtotal: state.cart?.totalPriceBeforeDiscount ?? 0,
                  discount: state.cart?.discount ?? 0,
                  subtotalAfterDiscount:
                      state.cart?.totalPriceAfterDiscount ?? 0,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
