import 'package:flutter/material.dart';
import 'package:restaurant_app/service/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  bool? _isScheduled = false;
  bool? get isScheduled => _isScheduled;

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification() {
    // _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "rqdv5juczeskfw1e867",
    );
  }

  void showBigPictureNotification() {
    _notificationId += 1;
    flutterNotificationService.showBigPictureNotification(
      id: _notificationId,
      title: "New Big Picture Notification",
      body: "This is a new big picture notification with id $_notificationId",
      payload:
          "This is a payload from big picture notification with id $_notificationId",
    );
  }

  void scheduleDailyLunchNotification() {
    flutterNotificationService.scheduleDailyLunchNotification(
      id: _notificationId,
    );
  }

  Future getNotification() async {
    _isScheduled =
        await flutterNotificationService.getNotification(_notificationId);
    notifyListeners();
  }

  Future<void> cancelNotification() async {
    await flutterNotificationService.cancelNotification(_notificationId);
  }
}
