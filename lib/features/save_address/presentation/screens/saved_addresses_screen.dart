import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/features/save_address/presentation/view_model/cubit/saved_addresses_view_model.dart';
import 'package:flowery/features/save_address/presentation/view_model/events/saved_addresses_events.dart';
import 'package:flowery/features/save_address/presentation/widgets/saved_addresses_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<SavedAddressesViewModel>()..doEvent(LoadSavedAddressesEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => context.pop(),
          ),
          title: const Text('Saved address'),
        ),
        body: const SavedAddressesBody(),
      ),
    );
  }
}
