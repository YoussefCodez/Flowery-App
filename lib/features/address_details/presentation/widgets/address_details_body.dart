import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/custom_text_field.dart';
import 'package:flowery/features/address_details/data/models/location/city_model.dart';
import 'package:flowery/features/address_details/data/models/location/governorate_model.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_dto_entity.dart';
import 'package:flowery/features/address_details/presentation/view_model/cubit/address_details_view_model.dart';
import 'package:flowery/features/address_details/presentation/view_model/events/address_details_events.dart';
import 'package:flowery/features/address_details/presentation/view_model/states/address_details_base_state.dart';
import 'package:flowery/features/address_details/presentation/widgets/map_widget.dart';
import 'package:flowery/features/save_address/presentation/screens/saved_addresses_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class AddressDetailsBody extends StatefulWidget {
  final AddressDetailsDtoEntity? addressToEdit;
  const AddressDetailsBody({super.key, this.addressToEdit});

  @override
  State<AddressDetailsBody> createState() => _AddressDetailsBodyState();
}

class _AddressDetailsBodyState extends State<AddressDetailsBody> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  late AppLocalizations localizations;

  @override
  void initState() {
    super.initState();
    if (widget.addressToEdit != null) {
      _addressController.text = widget.addressToEdit!.street ?? '';
      _phoneController.text = widget.addressToEdit!.phone ?? '';
      _recipientNameController.text = widget.addressToEdit!.username ?? '';
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _recipientNameController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  bool _isFormValid(AddressDetailsBaseState state) {
    return _addressController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _recipientNameController.text.trim().isNotEmpty &&
        state.selectedGovernorate != null &&
        state.selectedCity != null &&
        state.latitude != null &&
        state.longitude != null;
  }

  @override
  Widget build(BuildContext context) {
    localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocConsumer<AddressDetailsViewModel, AddressDetailsBaseState>(
        listenWhen: (previous, current) =>
            previous.isSavingAddress != current.isSavingAddress,
        listener: (context, state) {
          if (state.isSavingAddress) return;

          if (state.address != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Address saved successfully')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SavedAddressesScreen()),
            );
          } else if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AddressDetailsViewModel>(),
                          child: const MapWidget(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: IgnorePointer(
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              state.latitude ?? 30.0444,
                              state.longitude ?? 31.2357,
                            ),
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                              subdomains: const ['a', 'b', 'c', 'd'],
                              userAgentPackageName: 'com.example.flowery',
                            ),
                            if (state.latitude != null &&
                                state.longitude != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(
                                      state.latitude!,
                                      state.longitude!,
                                    ),
                                    width: 50,
                                    height: 50,
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                MainTextField(
                  hintText: localizations.enter_the_address,
                  controller: _addressController,
                  labelText: localizations.address,
                ),
                SizedBox(height: 24.h),
                MainTextField(
                  hintText: localizations.enter_the_the_phone_number,
                  controller: _phoneController,
                  labelText: localizations.phoneNumber,
                ),
                SizedBox(height: 24.h),
                MainTextField(
                  hintText: localizations.enter_the_recipient_name,
                  controller: _recipientNameController,
                  labelText: localizations.recipient_name,
                ),
                SizedBox(height: 24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<GovernorateModel>(
                        value: state.selectedGovernorate,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                        ),
                        items: state.governorates
                            .map(
                              (g) => DropdownMenuItem(
                                value: g,
                                child: Text(g.nameAr),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<AddressDetailsViewModel>().doEvent(
                              SelectGovernorateEvent(value),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 17.h),
                    Expanded(
                      child: DropdownButtonFormField<CityModel>(
                        value: state.selectedCity,
                        decoration: const InputDecoration(
                          labelText: 'Area',
                          border: OutlineInputBorder(),
                        ),
                        items: state.filteredCities
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.nameAr),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<AddressDetailsViewModel>().doEvent(
                              SelectCityEvent(value),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _addressController,
                    _phoneController,
                    _recipientNameController,
                  ]),
                  builder: (context, _) {
                    final isValid = _isFormValid(state);

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (state.isSavingAddress || !isValid)
                            ? null
                            : () {
                                final request = AddressDetailsRequest(
                                  street: _addressController.text,
                                  phone: _phoneController.text,
                                  city:
                                      state.selectedCity?.nameAr ??
                                      state.cityName,
                                  lat: state.latitude!.toString(),
                                  long: state.longitude!.toString(),
                                  username: _recipientNameController.text,
                                );

                                context.read<AddressDetailsViewModel>().doEvent(
                                  SaveAddressDetailsEvent(),
                                  request: request,
                                );
                              },
                        child: state.isSavingAddress
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                state.editingAddressId != null
                                    ? 'Update Address'
                                    : 'Save Address',
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
