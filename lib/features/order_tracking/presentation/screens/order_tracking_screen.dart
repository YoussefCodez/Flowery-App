import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/state/order_tracking_state.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/arrival_time_container.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/driver_info_container.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/state_time_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(localizations.track_order),
        titleSpacing: 0.0,
      ),
      body: BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
        builder: (context, state) {
          return state.orderInfoState.when(
            success: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Estimated Arrival
                  ArrivalTimeContainer(arrivalTime: data.acceptedAt ?? ""),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(thickness: 0.5),
                  ),

                  // Driver Info
                  DriverInfoContainer(
                    driverFirstName: data.driverFirstName ?? "",
                    driverLastName: data.driverLastName ?? "",
                    driverPhoneNumber: data.driverPhoneNumber ?? "",
                    driverImage: data.driverPhoto ?? "",
                  ),

                  // State Track
                  StateTimeLine(),
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
                content: Text(state.orderInfoState.exception.toString()),
              ),
            );
          }
        },
      ),
    );
  }
}
