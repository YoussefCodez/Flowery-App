import 'package:flowery/config/general_cubit/cart_manager/cart_events.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_manager.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_bill.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flowery/features/checkout/presentation/view_model/events/checkout_events.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceOrderButton extends StatelessWidget {
  final int subtotal;
  final int discount;
  final int subtotalAfterDiscount;
  final AppLocalizations localizations;
  final TextTheme textTheme;
  final GlobalKey<FormState> _formKey;
  const PlaceOrderButton({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.subtotalAfterDiscount,
    required this.localizations,
    required this.textTheme,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomBill(
                subtotal: subtotal,
                discount: discount,
                subtotalAfterDiscount: subtotalAfterDiscount,
                isItPlaceOrder: true,
              ),
              BlocConsumer<CheckoutCubit, CheckoutState>(
                listener: (context, state) async {
                  if (state.url != null && state.url != "") {
                    context.pushNamed(
                      AppRoutes.credit,
                      arguments: CreditWebViewArgs(
                        url: state.url!,
                        title: localizations.online_payment,
                        localizations: localizations
                      ),
                    );
                  }
                  if (state.isDone) {
                    // show snackBar of success
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(localizations.your_order_has_been_placed),
                      ),
                    );
                    // load the cart again then go back
                    context.read<CartManager>().doEvent(GetUserCartProductsEvent());
                    context.pushNamed(AppRoutes.home);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (state.selectedAddress != null) {
                        // Payment Method: Cash
                        if (!state.isCreditCard) {
                          context.read<CheckoutCubit>().doEvent(
                            CheckoutUsingCashEvent(
                              request: CreateCashOrderRequest(
                                shippingAddress: ShippingAddress(
                                  city: "test",
                                  lat: "test",
                                  long: "test",
                                  phone: "test",
                                  street: "test",
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Payment Method: Credit
                          if (state.isGift) {
                            if (_formKey.currentState!.validate()) {
                              context.read<CheckoutCubit>().doEvent(
                                CheckoutUsingCreditEvent(),
                              );
                            }
                          } else {
                            context.read<CheckoutCubit>().doEvent(
                              CheckoutUsingCreditEvent(),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations.please_select_an_address,
                            ),
                          ),
                        );
                      }
                    },
                    child: state.isLoading
                        ? Center(
                            child: SizedBox(
                              height: 25.h,
                              width: 25.w,
                              child: const CircularProgressIndicator(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          )
                        : Text(localizations.place_order),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}

class CreditWebViewArgs {
  final String url;
  final String title;
  final AppLocalizations localizations;

  const CreditWebViewArgs({
    required this.url,
    required this.title,
    required this.localizations,
  });
}
