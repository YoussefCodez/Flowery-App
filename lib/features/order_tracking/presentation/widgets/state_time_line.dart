import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/state/order_tracking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines_plus/timelines_plus.dart';

class StateTimeLine extends StatefulWidget {
  const StateTimeLine({super.key});

  @override
  State<StateTimeLine> createState() => _StateTimeLineState();
}

class _StateTimeLineState extends State<StateTimeLine> {
  late AppLocalizations localizations;
  late TextTheme textTheme;
  late List<String> statuses;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    statuses = [
      localizations.received_your_order,
      localizations.preparing_your_order,
      localizations.out_for_delivery,
      localizations.arrived,
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 250.h,
              child: Timeline.tileBuilder(
                theme: TimelineThemeData(nodePosition: 0.1),
                builder: TimelineTileBuilder.connected(
                  itemCount: statuses.length,
                  connectionDirection: ConnectionDirection.before,

                  contentsBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15.h, left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),
                          Text(statuses[index], style: textTheme.titleMedium),
                        ],
                      ),
                    );
                  },

                  indicatorBuilder: (_, index) {
                    final completed = index <= state.currentState;

                    return Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        DotIndicator(
                          size: 24,
                          color: completed
                              ? AppColors.primaryColor
                              : AppColors.lightGrayColor,
                          child: Icon(
                            Icons.circle,
                            size: 20,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: completed
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                        ),
                      ],
                    );
                  },

                  connectorBuilder: (_, index, _) {
                    return SolidLineConnector(
                      color: index <= state.currentState
                          ? AppColors.primaryColor
                          : AppColors.lightGrayColor,
                      thickness: 2,
                    );
                  },
                ),
              ),
            ),
            // Show Map Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.currentState == 3
                  ? Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => context.pushNamed(
                                AppRoutes.orderTrackingMap,
                                arguments: context.read<OrderTrackingCubit>(),
                              ),
                              child: Text(localizations.show_map),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => {},
                              child: Text(localizations.order_delivered),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () => context.pushNamed(
                        AppRoutes.orderTrackingMap,
                        arguments: context.read<OrderTrackingCubit>(),
                      ),
                      child: Text(localizations.show_map),
                    ),
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
    );
  }
}
