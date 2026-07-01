import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_manager.dart';
import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/remote_config_service/remote_config_service.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/address_picker_sheet.dart';
import 'package:flowery/core/widgets/custom_bill.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/checkout/data/models/requests/create_cash_order_request.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/checkout_view_model.dart';
import 'package:flowery/features/checkout/presentation/view_model/events/checkout_events.dart';
import 'package:flowery/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flowery/features/checkout/presentation/widgets/custom_address_container.dart';
import 'package:flowery/features/checkout/presentation/widgets/payment_method_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutScreen extends StatefulWidget {
  final int subtotal;
  final int discount;
  final int subtotalAfterDiscount;
  const CheckoutScreen({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.subtotalAfterDiscount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late AppLocalizations localizations;
  late TextTheme textTheme;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final deliveryDays = RemoteConfigService.deliveryDays;

  final savedAddresses = [
    SavedAddress(addressTitle: "Home", addressDetails: "2XVP+XC - Ramsis"),
    SavedAddress(addressTitle: "Office", addressDetails: "2XVP+XC - Smouha"),
  ];

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryDate = DateTime.now().add(Duration(days: deliveryDays));
    return BlocProvider<CheckoutViewModel>(
      create: (context) => getIt.get<CheckoutViewModel>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              titleSpacing: 0.0,
              title: Text(localizations.checkout),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery time
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 3.w),
                              Text(
                                localizations.delivery_time,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 25.sp),
                              Text(
                                localizations.instant,
                                style: textTheme.labelLarge,
                              ),
                              Text(
                                " ${localizations.arrive_by} $deliveryDate",
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
                    Divider(
                      color: AppColors.dividerColor,
                      height: 24.h,
                      thickness: 24.h,
                    ),

                    // Delivery address
                    // AddressPickerSheet(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            SizedBox(width: 11.w),
                            Text(
                              localizations.delivery_address,
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomAddressContainer(
                              addressTitle: savedAddresses[index].addressTitle,
                              addressDetails:
                                  savedAddresses[index].addressDetails,
                            );
                          },
                          itemCount: 2,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          foregroundColor: AppColors.blackColor,
                          side: BorderSide(
                            color: AppColors.grayColor,
                            width: 1,
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: AppColors.primaryColor),
                            SizedBox(width: 5),
                            Text(
                              localizations.add_new,
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.dividerColor,
                      height: 24.h,
                      thickness: 24.h,
                    ),

                    // Delivery Payment Method
                    Column(
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
                        BlocBuilder<CheckoutViewModel, CheckoutState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                PaymentMethodContainer(
                                  isThisCreditCardContainer: false,
                                  paymentMethodName:
                                      localizations.cash_on_delivery,
                                  selectedMethod: state.isCreditCard,
                                ),
                                PaymentMethodContainer(
                                  isThisCreditCardContainer: true,
                                  paymentMethodName: localizations.credit_card,
                                  selectedMethod: state.isCreditCard,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.dividerColor,
                      height: 24.h,
                      thickness: 24.h,
                    ),

                    // (optional Gift)
                    BlocBuilder<CheckoutViewModel, CheckoutState>(
                      builder: (BuildContext context, CheckoutState state) {
                        if (state.isCreditCard) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        CupertinoSwitch(
                                          value: state.isGift,
                                          activeTrackColor:
                                              AppColors.primaryColor,
                                          onChanged: (value) {
                                            context
                                                .read<CheckoutViewModel>()
                                                .doEvent(
                                                  ToggleGiftEvent(value),
                                                );
                                          },
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          localizations.it_is_a_gift,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MainTextField(
                                        enabled: state.isGift,
                                        hintText: localizations.enter_the_name,
                                        labelText: localizations.name,
                                        controller: nameController,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return localizations
                                                .name_is_required;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MainTextField(
                                        enabled: state.isGift,
                                        hintText: localizations
                                            .enter_the_phone_number,
                                        labelText: localizations.phone,
                                        controller: phoneController,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return localizations
                                                .phone_is_required;
                                          }
                                          if (!AppRegExp.isPhoneNumberValid(
                                            value,
                                          )) {
                                            return localizations
                                                .phone_number_is_not_valid;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColors.dividerColor,
                                height: 24.h,
                                thickness: 24.h,
                              ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },

                      // Money Details + place order
                    ),

                    // Place order Button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CustomBill(
                            subtotal: widget.subtotal,
                            discount: widget.discount,
                            subtotalAfterDiscount: widget.subtotalAfterDiscount,
                            isItPlaceOrder: true,
                          ),
                          BlocConsumer<CheckoutViewModel, CheckoutState>(
                            listener: (context, state) async {
                              if (state.url != null && state.url != "") {
                                await launchCheckoutUrl(state.url ?? "");
                              }
                              if (state.isDone) {
                                // show snackBar of success
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      localizations.your_order_has_been_placed,
                                    ),
                                  ),
                                );
                                // load the cart again then go back
                                context.read<CartManager>().loadCart();
                                context.pop();
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (state.selectedAddress != null) {
                                    // Payment Method: Cash
                                    if (!state.isCreditCard) {
                                      context.read<CheckoutViewModel>().doEvent(
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
                                          context
                                              .read<CheckoutViewModel>()
                                              .doEvent(
                                                CheckoutUsingCreditEvent(),
                                              );
                                        }
                                      } else {
                                        context
                                            .read<CheckoutViewModel>()
                                            .doEvent(
                                              CheckoutUsingCreditEvent(),
                                            );
                                      }
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          localizations
                                              .please_select_an_address,
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
                                          child:
                                              const CircularProgressIndicator(
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> launchCheckoutUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

class SavedAddress {
  final String addressTitle;
  final String addressDetails;

  SavedAddress({required this.addressTitle, required this.addressDetails});
}
