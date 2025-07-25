import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/notifications_service.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(NotificationState(
          notificationsEnabled: NotificationService.permissionGranted,
          notificationBadgeCount: NotificationService.badge,
          isNotificationScreenOpen: false,
        ));

  void toggleNotifications() {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  }

  bool get isNotificationEnabled => state.notificationsEnabled;

  void setNotificationScreenOpen(bool isOpen) {
    if (state.isNotificationScreenOpen == isOpen) return;

    if (isOpen) {
      NotificationService.resetBadge();
      emit(state.copyWith(
        isNotificationScreenOpen: true,
        notificationBadgeCount: 0,
      ));
    } else {
      emit(state.copyWith(isNotificationScreenOpen: false));
    }
  }

  void incrementNotificationBadge() {
    debugPrint('🔔 Trying to increment badge');
    debugPrint(
        '🔍 isNotificationScreenOpen: ${state.isNotificationScreenOpen}');
    debugPrint('🔢 current badge: ${state.notificationBadgeCount}');

    if (!state.isNotificationScreenOpen) {
      final newCount = state.notificationBadgeCount + 1;
      debugPrint('✅ Badge incremented to: $newCount');
      emit(state.copyWith(notificationBadgeCount: newCount));
    } else {
      debugPrint('⛔ Notification screen open — skipping badge increment');
    }
  }

  void clearNotificationBadge() {
    emit(state.copyWith(notificationBadgeCount: 0));
  }
}
