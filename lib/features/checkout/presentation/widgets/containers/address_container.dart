import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/checkout/domain/entities/saved_addresses.dart';
import 'package:flowery/features/checkout/presentation/widgets/cards/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddressContainer extends StatelessWidget {
  final AppLocalizations localizations;
  final TextTheme textTheme;

    final savedAddresses = [
    SavedAddress(
      addressTitle: "Home",
      city: "Cairo",
      street: "2XVP+XC - Ramsis",
      phone: "01012345678",
      lat: "30.0626",
      long: "31.2497",
    ),
    SavedAddress(
      addressTitle: "Office",
      city: "Alexandria",
      street: "2XVP+XC - Smouha",
      phone: "01087654321",
      lat: "31.2156",
      long: "29.9553",
    ),
  ];

  CustomAddressContainer({super.key, required this.localizations, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                            return AddressCard(
                              addressTitle: savedAddresses[index].addressTitle,
                              addressDetails: savedAddresses[index].street,
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
    ],);
  }
}