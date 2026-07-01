import 'package:flowery/config/general_cubit/address_view_model/cubit/address_status_cubit.dart';
import 'package:flowery/config/general_cubit/address_view_model/events/address_status_events.dart';
import 'package:flowery/config/general_cubit/address_view_model/states/address_status_state.dart';
import 'package:flowery/features/address_details/presentation/screens/address_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressPickerSheet extends StatelessWidget {
  const AddressPickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const AddressPickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressStatusCubit, AddressStatusState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Choose delivery address',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (_) => const SavedAddressesScreen()),
                    //     );
                    //   },
                    //   child: const Text('Manage'),
                    // ),
                  ],
                ),
                SizedBox(height: 8.h),
                if (state.addresses.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Text('No saved addresses yet'),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.addresses.length,
                      separatorBuilder: (_, __) => Divider(height: 1.h),
                      itemBuilder: (context, index) {
                        final address = state.addresses[index];
                        final isSelected =
                            state.currentAddress?.id == address.id;

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          title: Text(
                            '${address.street ?? ''} - ${address.city ?? ''}',
                          ),
                          subtitle: Text(address.phone ?? ''),
                          onTap: () {
                            context.read<AddressStatusCubit>().doEvent(
                              SelectAddressEvent(address),
                            );
                            // Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add new address'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddressDetailsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
