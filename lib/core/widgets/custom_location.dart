import 'package:flowery/config/general_cubit/address_view_model/cubit/address_status_cubit.dart';
import 'package:flowery/config/general_cubit/address_view_model/states/address_status_state.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/address_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationCustomWidget extends StatelessWidget {
  const LocationCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressStatusCubit, AddressStatusState>(
      builder: (context, state) {
        final address = state.currentAddress;
        final label = address != null
            ? "Deliver to ${address.street ?? ''} - ${address.city ?? ''}"
            : "Add your address";

        return GestureDetector(
          onTap: () => AddressPickerSheet.show(context),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined),
              SizedBox(width: 8.w),
              Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
              SizedBox(width: 6.w),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
