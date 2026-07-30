import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/order_tracking/presentation/screens_helpers/screen_helper_funtions.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/state/order_tracking_state.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/arrival_time_container.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/driver_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class OrderTrackingMapScreen extends StatefulWidget {
  const OrderTrackingMapScreen({super.key});

  @override
  State<OrderTrackingMapScreen> createState() => _OrderTrackingMapScreenState();
}

class _OrderTrackingMapScreenState extends State<OrderTrackingMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
        builder: (context, state) {
          return state.coordsInfoState.when(
            loading: () => const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            ),
            error: (errorMessage) => SizedBox.shrink(),
            initial: () => const SizedBox.shrink(),
            success: (data) {
              final LatLng driverLocation = LatLng(
                data.driverLat!,
                data.driverLong!,
              );
              final LatLng userLocation = LatLng(data.userLat!, data.userLong!);

              return FutureBuilder(
                future: getRealRoadRoute(driverLocation, userLocation),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final routePoints = snapshot.data!;
                  return Column(
                    children: [
                      Expanded(
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: driverLocation,
                            initialZoom: 13.0,
                          ),
                          children: [
                            // Map
                            TileLayer(
                              urlTemplate: Apikeys.openStreetMap,
                              userAgentPackageName: Apikeys.packageName,
                            ),

                            // Route
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: routePoints,
                                  color: AppColors.blackColor,
                                  strokeWidth: 5.0,
                                ),
                              ],
                            ),

                            // Source & destination
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: driverLocation,
                                  width: 40,
                                  height: 40,
                                  child: const FaIcon(
                                    FontAwesomeIcons.carSide,
                                    color: AppColors.primaryColor,
                                    size: 40,
                                  ),
                                ),
                                Marker(
                                  point: userLocation,
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.location_pin,
                                    color: AppColors.primaryColor,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      state.orderInfoState.when(
                        success: (data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Estimated Arrival
                              ArrivalTimeContainer(
                                arrivalTime: data.acceptedAt ?? "",
                              ),

                              // Divider
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Divider(thickness: 0.5),
                              ),

                              // Driver Info
                              DriverInfoContainer(
                                driverFirstName: data.driverFirstName ?? "",
                                driverLastName: data.driverLastName ?? "",
                                driverPhoneNumber: data.driverPhoneNumber ?? "",
                                driverImage: data.driverPhoto ?? "",
                              ),
                            ],
                          );
                        },
                        loading: () => const Center(
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (errorMessage) => SizedBox.shrink(),
                        initial: () => const SizedBox.shrink(),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        listener: (context, state) {
          if (state.coordsInfoState.exception != null &&
              state.coordsInfoState.exception.toString().isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.coordsInfoState.exception.toString()),
              ),
            );
          }
        },
      ),
    );
  }
}
