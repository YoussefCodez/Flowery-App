import 'package:flowery/features/address_details/presentation/screens/address_details_screen.dart';
import 'package:flowery/features/save_address/presentation/view_model/cubit/saved_addresses_view_model.dart';
import 'package:flowery/features/save_address/presentation/view_model/events/saved_addresses_events.dart';
import 'package:flowery/features/save_address/presentation/view_model/states/saved_addresses_base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAddressesBody extends StatelessWidget {
  const SavedAddressesBody({super.key});

  Future<void> _confirmDelete(BuildContext context, String addressId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete address'),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      context.read<SavedAddressesViewModel>().doEvent(DeleteAddressEvent(addressId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedAddressesViewModel, SavedAddressesBaseState>(
      listenWhen: (previous, current) => previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.addresses.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                const Expanded(child: Center(child: Text('No saved addresses yet'))),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressDetailsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                    ),
                    child: const Text('Add new address', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: state.addresses.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final address = state.addresses[index];
                    final isDeletingThis = state.isDeleting && state.deletingAddressId == address.id;

                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  address.city ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              if (isDeletingThis)
                                const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              else ...[
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () => _confirmDelete(context, address.id ?? ''),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddressDetailsScreen(addressToEdit: address),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(address.street ?? '', style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressDetailsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                  ),
                  child: const Text('Add new address', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}