import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
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
                  return const Center(
                    child: Text("No Notifications"),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];

                    return Card(
                      elevation: 2,
                      color: notification.isRead == true
                          ? Colors.white
                          : Colors.green.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          notification.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(notification.body ?? ""),
                            const SizedBox(height: 8),
                            Text(
                              notification.createdAt ?? "",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: notification.isRead == false
                            ? Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        )
                            : null,
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