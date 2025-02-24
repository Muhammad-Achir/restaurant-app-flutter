import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant_app.dart';
import 'package:restaurant_app/service/local_notification_service.dart';
import 'package:restaurant_app/service/work_manager_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // needed in share preferences and background notification
  WidgetsFlutterBinding.ensureInitialized();
  // await WorkManagerService().init();

  final pref = await SharedPreferences.getInstance();

  final notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  String route = NavigationRoute.mainRoute.name;

  String? payload;

  final notificationResponse =
      notificationAppLaunchDetails!.notificationResponse;

  if (notificationResponse?.payload != '') {
    if (notificationAppLaunchDetails.didNotificationLaunchApp) {
      route = NavigationRoute.detailRoute.name;
      payload = notificationResponse?.payload;
    }
  }

  runApp(
    RestaurantApp(
      payload: payload,
      pref: pref,
      route: route,
    ),
  );
}
