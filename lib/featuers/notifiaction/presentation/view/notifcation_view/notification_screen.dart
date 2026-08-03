import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flowery/config/error/handle_errors.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/extensions/date_extension.dart';
import 'package:flowery/core/theme/app_colors.dart';

import '../../../../../config/di/injectable_config.dart';
import '../../view_model/notifcation_bloc.dart';
import '../../view_model/notifcation_event.dart';
import '../../view_model/notifcation_state.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final NotificationCubit cubit = getIt()..doEvent(GetNotifications());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.notifications),
          centerTitle: true,
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            return state.notificationsState.when(
              initial: () => const SizedBox(),

              loading: () =>
                  const Center(child: CircularProgressIndicator()),

              error: (exception) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.redColor,
                      size: 48.r,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      handleError(exception, l10n) ?? l10n.an_error_occurred,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.lightGrayColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),

              success: (notifications) {
                if (notifications.isEmpty) {
                  return Center(
                    child: Text(l10n.no_notifications),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: notifications.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    final body = (notification.body ?? '')
                        .trimRight()
                        .replaceAll(RegExp(r'\.$'), '');

                    return Card(
                      elevation: 2,
                      color: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.whiteColor,
                            size: 20.r,
                          ),
                        ),
                        title: Text(
                          notification.title ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4.h),
                            Text(
                              body,
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              notification.createdAt.toFormattedDateTime(),
                              style: TextStyle(
                                color: AppColors.lightGrayColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
