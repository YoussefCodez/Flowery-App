import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/remote_config_service/remote_config_service.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_bill.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
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
  final int deliveryFee;
  const CheckoutScreen({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.subtotalAfterDiscount,
    required this.deliveryFee,
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
    SavedAddress(
      addressTitle: "Home",
      addressDetails: "2XVP+XC - Ramsis",
      selectedAddress: true,
    ),
    SavedAddress(
      addressTitle: "Office",
      addressDetails: "2XVP+XC - Sheikh Zayed",
      selectedAddress: false,
    ),
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
          return BlocListener<CheckoutViewModel, CheckoutState>(
            listener: (context, state) async {
              if (state.url != null) {
                await launchCheckoutUrl(state.url!);
              }
            },
            child: Scaffold(
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
                                addressTitle:
                                    savedAddresses[index].addressTitle,
                                addressDetails:
                                    savedAddresses[index].addressDetails,
                                selectedAddress:
                                    savedAddresses[index].selectedAddress,
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
                              if (state.isCreditCard) {
                                return Column(
                                  children: [
                                    PaymentMethodContainer(
                                      paymentMethodName:
                                          localizations.cash_on_delivery,
                                      selectedMethod: !state.isCreditCard,
                                      isCreditCard: false,
                                    ),
                                    PaymentMethodContainer(
                                      paymentMethodName:
                                          localizations.credit_card,
                                      selectedMethod: state.isCreditCard,
                                      isCreditCard: true,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    PaymentMethodContainer(
                                      paymentMethodName:
                                          localizations.cash_on_delivery,
                                      selectedMethod: !state.isCreditCard,
                                      isCreditCard: false,
                                    ),
                                    PaymentMethodContainer(
                                      paymentMethodName:
                                          localizations.credit_card,
                                      selectedMethod: state.isCreditCard,
                                      isCreditCard: true,
                                    ),
                                  ],
                                );
                              }
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
                                                    CheckoutUsingGiftEvent(),
                                                    isGift: value,
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
                                          hintText:
                                              localizations.enter_the_name,
                                          labelText: localizations.name,
                                          controller: nameController,
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CustomBill(
                              subtotal: widget.subtotal,
                              discount: widget.discount,
                              subtotalAfterDiscount:
                                  widget.subtotalAfterDiscount,
                              deliveryFee: widget.deliveryFee,
                              isItPlaceOrder: true,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CheckoutViewModel>().doEvent(
                                  CheckoutUsingCreditEvent(),
                                );
                                // if (_formKey.currentState!.validate()) {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return AlertDialog(
                                //       title: Text(localizations.success),
                                //       content: Text(
                                //         localizations.your_order_has_been_placed,
                                //       ),
                                //       actions: [
                                //         ElevatedButton(
                                //           onPressed: () {
                                //             context.read<CartManager>().deleteCart();
                                //             context.read<CartManager>().loadCart();
                                //             // close dialog
                                //             context.pop();
                                //             // Navigate to home
                                //             context.pushReplacementNamed(
                                //               AppRoutes.mainLayout,
                                //             );
                                //           },
                                //           child: Text(localizations.go_to_home),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                                // }
                              },
                              child:
                                  BlocBuilder<CheckoutViewModel, CheckoutState>(
                                    builder: (context, state) {
                                      if (state.isLoading) {
                                        return Center(
                                          child: SizedBox(
                                            height: 25.h,
                                            width: 25.w,
                                            child:
                                                const CircularProgressIndicator(
                                                  color: AppColors.whiteColor,
                                                ),
                                          ),
                                        );
                                      } else {
                                        return Text(localizations.place_order);
                                      }
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
  final bool selectedAddress;

  SavedAddress({
    required this.addressTitle,
    required this.addressDetails,
    required this.selectedAddress,
  });
}
