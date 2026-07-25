import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/state/order_tracking_state.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/arrival_time_container.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/driver_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:routing_client_dart/routing_client_dart.dart';

class OrderTrackingMapScreen extends StatefulWidget {
  const OrderTrackingMapScreen({super.key});

  @override
  State<OrderTrackingMapScreen> createState() => _OrderTrackingMapScreenState();
}

class _OrderTrackingMapScreenState extends State<OrderTrackingMapScreen> {
  // Define your start and end points
  final LatLng sourcePoint = const LatLng(30.0444, 31.2357); // e.g., Store
  final LatLng destinationPoint = const LatLng(
    30.0631,
    31.3347,
  ); // e.g., Customer

  List<LatLng> routePoints = [];
  bool isLoadingRoute = true;

  @override
  void initState() {
    super.initState();
    _getRealRoadRoute();
  }

  Future<void> _getRealRoadRoute() async {
    try {
      final manager = RoutingManager();

      // Request real driving directions from OSRM public backend
      final result = await manager.getRoute(
        request: OSRMRequest.route(
          waypoints: [
            LngLat(lng: sourcePoint.longitude, lat: sourcePoint.latitude),
            LngLat(
              lng: destinationPoint.longitude,
              lat: destinationPoint.latitude,
            ),
          ],
          geometries: Geometries.polyline,
        ),
      );

      // Extract the detailed street coordinates from the result
      final poiList = result.polyline;

      setState(() {
        routePoints =
            poiList?.map((point) => LatLng(point.lat, point.lng)).toList() ??
            [];
        isLoadingRoute = false;
      });
    } catch (e) {
      // Fallback to straight line if network or routing fails
      setState(() {
        routePoints = [sourcePoint, destinationPoint];
        isLoadingRoute = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadingRoute
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: sourcePoint,
                      initialZoom: 13.0,
                    ),
                    children: [
                      // 1. OpenStreetMap Tile background
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.flowery.app',
                      ),

                      // 2. Draw the actual road path polyline
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points:
                                routePoints, // Contains all road geometry turns
                            color: AppColors.primaryColor,
                            strokeWidth: 5.0,
                          ),
                        ],
                      ),

                      // 3. Source and Destination Markers
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: sourcePoint,
                            width: 40,
                            height: 40,
                            child: const FaIcon(
                              FontAwesomeIcons.carSide,
                              color: AppColors.primaryColor,
                              size: 40,
                            ),
                          ),
                          Marker(
                            point: destinationPoint,
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
                BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
                  builder: (context, state) {
                    return state.orderInfoState.when(
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
                    );
                  },
                  listener: (context, state) {
                    if (state.orderInfoState.exception != null &&
                        state.orderInfoState.exception.toString().isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.orderInfoState.exception.toString(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
    );
  }
}
