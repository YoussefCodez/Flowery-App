import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/checkout/presentation/helpers/checkout_validators.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flowery/features/checkout/presentation/view_model/events/checkout_events.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/checkout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftContainer extends StatelessWidget {
  final AppLocalizations localizations;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  const GiftContainer({
    super.key,
    required this.localizations,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return // (optional Gift)
    BlocBuilder<CheckoutCubit, CheckoutState>(
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
                          activeTrackColor: AppColors.primaryColor,
                          onChanged: (value) {
                            context.read<CheckoutCubit>().doEvent(
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
                        validator: (value) => CheckoutValidators.validateName(
                          value,
                          localizations,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainTextField(
                        enabled: state.isGift,
                        hintText: localizations.enter_the_phone_number,
                        labelText: localizations.phone,
                        controller: phoneController,
                        obscureText: false,
                        validator: (value) => CheckoutValidators.validatePhone(
                          value,
                          localizations,
                        ),
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
    );
  }
}
