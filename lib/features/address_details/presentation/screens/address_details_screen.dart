import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/features/address_details/presentation/view_model/cubit/address_details_view_model.dart';
import 'package:flowery/features/address_details/presentation/view_model/events/address_details_events.dart';
import 'package:flowery/features/address_details/presentation/widgets/address_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressDetailsViewModel>()
        ..doEvent(LoadGovernoratesEvent())
        ..doEvent(LoadCitiesEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Address'),
        ),
        body: const AddressDetailsBody(),
      ),
    );
  }
}