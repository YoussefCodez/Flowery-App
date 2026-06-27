import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';
import 'package:flowery/features/address_details/presentation/view_model/cubit/address_details_view_model.dart';
import 'package:flowery/features/address_details/presentation/view_model/events/address_details_events.dart';
import 'package:flowery/features/address_details/presentation/widgets/address_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDetailsScreen extends StatelessWidget {
  final AddressDetailsDtoEntity? addressToEdit;
  const AddressDetailsScreen({super.key, this.addressToEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<AddressDetailsViewModel>();
        if (addressToEdit != null) {
          cubit.doEvent(LoadAddressForEditEvent(addressToEdit!));
        } else {
          cubit.doEvent(LoadGovernoratesEvent());
          cubit.doEvent(LoadCitiesEvent());
        }
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(addressToEdit != null ? 'Edit Address' : 'Address'),
        ),
        body: AddressDetailsBody(addressToEdit: addressToEdit),
      ),
    );
  }
}