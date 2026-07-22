import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../config/di/injectable_config.dart';
import '../../view_model/notifcation_bloc.dart';
import '../../view_model/notifcation_event.dart';
import '../../view_model/notifcation_state.dart';

String _formatDate(String? raw) {
  if (raw == null || raw.isEmpty) return '';
  try {
    final dt = DateTime.parse(raw).toLocal();
    final date = DateFormat('d MMM yyyy').format(dt);
    final time = DateFormat('h:mm a').format(dt);
    return '$date  •  $time';
  } catch (_) {
    return raw;
  }
}

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
                child: Text(exception.toString()),
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
                              _formatDate(notification.createdAt),
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
