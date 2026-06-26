import 'package:flowery/features/address_details/presentation/view_model/cubit/address_details_view_model.dart';
import 'package:flowery/features/address_details/presentation/view_model/events/address_details_events.dart';
import 'package:flowery/features/address_details/presentation/view_model/states/address_details_base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    context.read<AddressDetailsViewModel>().doEvent(
      GetCurrentDeviceLocationEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<AddressDetailsViewModel, AddressDetailsBaseState>(
        listenWhen: (previous, current) =>
            previous.currentDeviceLatitude != current.currentDeviceLatitude ||
            previous.currentDeviceLongitude != current.currentDeviceLongitude,
        listener: (context, state) {
          if (state.currentDeviceLatitude != null &&
              state.currentDeviceLongitude != null) {
            mapController.move(
              LatLng(
                state.currentDeviceLatitude!,
                state.currentDeviceLongitude!,
              ),
              15,
            );
          }
        },
        builder: (context, state) {
          final selectedLocation =
              (state.latitude != null && state.longitude != null)
              ? LatLng(state.latitude!, state.longitude!)
              : null;

          final currentDeviceLocation =
              (state.currentDeviceLatitude != null &&
                  state.currentDeviceLongitude != null)
              ? LatLng(
                  state.currentDeviceLatitude!,
                  state.currentDeviceLongitude!,
                )
              : null;

          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: const LatLng(30.0444, 31.2357),
              initialZoom: 13,
              onTap: (tapPosition, point) {
                context.read<AddressDetailsViewModel>().doEvent(
                  SelectLocationOnMapEvent(
                    latitude: point.latitude,
                    longitude: point.longitude,
                  ),
                );
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://a.tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flowery',
              ),
              if (selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation,
                      width: 50,
                      height: 50,
                      child: const Icon(Icons.location_pin, size: 40),
                    ),
                  ],
                )
              else if (currentDeviceLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: currentDeviceLocation,
                      width: 50,
                      height: 50,
                      child: const Icon(Icons.location_pin, size: 40),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
